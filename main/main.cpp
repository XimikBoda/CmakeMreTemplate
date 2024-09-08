#include "vmsys.h"
#include "vmio.h"
#include "vmgraph.h"
#include "vmchset.h"
#include "vmstdlib.h"
#include "vm4res.h"
#include "vmres.h"

VMINT		layer_hdl[1];	// layer handle array. 
VMUINT8* layer_buf = 0;

VMINT screen_w = 0;
VMINT screen_h = 0;
VMUINT8* demo_canvas = 0;

void handle_sysevt(VMINT message, VMINT param); // system events 
void handle_keyevt(VMINT event, VMINT keycode); // key events 
void handle_penevt(VMINT event, VMINT x, VMINT y); // pen events

static void draw_hello(void);


void vm_main(void) {
	layer_hdl[0] = -1;
	screen_w = vm_graphic_get_screen_width();
	screen_h = vm_graphic_get_screen_height();
	
	vm_reg_sysevt_callback(handle_sysevt);
	vm_reg_keyboard_callback(handle_keyevt);
	vm_reg_pen_callback(handle_penevt);

	VMINT size = 0;
	VMUINT8* res = vm_load_resource("demo.png", &size);
	demo_canvas = (VMUINT8*)vm_graphic_load_image(res, size);
	vm_free(res);
}

void handle_sysevt(VMINT message, VMINT param) {
#ifdef		SUPPORT_BG
	switch (message) {
	case VM_MSG_CREATE:
		break;
	case VM_MSG_PAINT:
		layer_hdl[0] = vm_graphic_create_layer(0, 0, screen_w, screen_h, -1);

		layer_buf = vm_graphic_get_layer_buffer(layer_hdl[0]);
		
		vm_graphic_set_clip(0, 0, screen_w, screen_h);
		
		draw_hello();
		break;
	case VM_MSG_HIDE:	
		if( layer_hdl[0] != -1 )
		{
			vm_graphic_delete_layer(layer_hdl[0]);
			layer_hdl[0] = -1;
		}
		break;
	case VM_MSG_QUIT:
		if( layer_hdl[0] != -1 )
		{
			vm_graphic_delete_layer(layer_hdl[0]);
			layer_hdl[0] = -1;
		}
		break;
	}
#else
	switch (message) {
	case VM_MSG_CREATE:
	case VM_MSG_ACTIVE:
		layer_hdl[0] = vm_graphic_create_layer(0, 0, screen_w, screen_h, -1);

		layer_buf = vm_graphic_get_layer_buffer(layer_hdl[0]);

		vm_graphic_set_clip(0, 0, screen_w, screen_h);
		break;
		
	case VM_MSG_PAINT:
		draw_hello();
		break;
		
	case VM_MSG_INACTIVE:
		if( layer_hdl[0] != -1 )
			vm_graphic_delete_layer(layer_hdl[0]);
		
		break;	
	case VM_MSG_QUIT:
		if( layer_hdl[0] != -1 )
			vm_graphic_delete_layer(layer_hdl[0]);
		break;	
	}
#endif
}

void handle_keyevt(VMINT event, VMINT keycode) {
	if( layer_hdl[0] != -1 ) {
		vm_graphic_delete_layer(layer_hdl[0]);
		layer_hdl[0] = -1;
	}
	
	vm_exit_app();	
}

void handle_penevt(VMINT event, VMINT x, VMINT y) {
	if( layer_hdl[0] != -1 ){
		vm_graphic_delete_layer(layer_hdl[0]);
		layer_hdl[0] = -1;
	}
	
	vm_exit_app();
}

static void draw_hello(void) {

	VMWCHAR s[100];
	int x;
	int y;
	int wstr_len;
	vm_graphic_color color;	

	
	vm_ascii_to_ucs2(s, 200, "Hello Cmake!");
	
	wstr_len = vm_graphic_get_string_width(s);

	x = (screen_w - wstr_len) / 2;
	y = (screen_h - vm_graphic_get_character_height()) / 2;
	
	color.vm_color_565 = VM_COLOR_WHITE;
	vm_graphic_setcolor(&color);
	
	vm_graphic_fill_rect_ex(layer_hdl[0], 0, 0, screen_w, screen_h);
	
	color.vm_color_565 = VM_COLOR_BLUE;
	vm_graphic_setcolor(&color);
	
	vm_graphic_textout_to_layer(layer_hdl[0],x, y, s, vm_wstrlen(s)); 

	vm_graphic_blt(layer_buf, (screen_w - 100) / 2, screen_h - 100, demo_canvas, 0, 0, 100, 100, 1);
	
	vm_graphic_flush_layer(layer_hdl, 1);
}

