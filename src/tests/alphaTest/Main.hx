package tests.alphaTest;

import away3d.materials.ColorMaterial;
import away3d.materials.TextureMaterial;
import away3d.textures.BitmapTexture;

import away3d.primitives.PlaneGeometry;
import away3d.entities.Mesh;
import openfl.geom.Vector3D;
import away3d.cameras.lenses.OrthographicLens;
import away3d.controllers.LookAtController;
import away3d.containers.View3D;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.BitmapData;

import openfl.events.Event;

class Main extends Sprite {
    private var view:View3D;
    private var controller:LookAtController;

    public function new() {
        super();
        init();
    }

    private function init():Void {
        initEngine();
        initObjects();

        view.setRenderCallback(onEnterFrame);
        view.render();
    }

    private function initEngine():Void {
        view = new View3D();
        view.camera.lens = new OrthographicLens(512);
        view.camera.position = new Vector3D(0, 2000, 0);

        this.addChild(view);

        controller = new LookAtController(view.camera);
        controller.lookAtPosition = new Vector3D(0,0,0);

        this.addChild(view);
        this.addChild(new away3d.debug.AwayFPS(view, 10, 10, 0xffffff, 3));
    }

    private function initObjects():Void {
        var baseMaterial:TextureMaterial = new TextureMaterial(new BitmapTexture(Assets.getBitmapData("images/base.png")));
        var base:Mesh = new Mesh(new PlaneGeometry(512, 512), baseMaterial);

        var splatterMaterial:TextureMaterial = new TextureMaterial(new BitmapTexture(Assets.getBitmapData("images/splatter.png")));
        splatterMaterial.alphaBlending = true;
        splatterMaterial.alphaPremultiplied = true;

        var splatter:Mesh = new Mesh(new PlaneGeometry(512, 512), splatterMaterial);

        var glyphsMaterial:TextureMaterial = new TextureMaterial(new BitmapTexture(Assets.getBitmapData("images/glyphs.png")));
        glyphsMaterial.alphaBlending = true;
        glyphsMaterial.alphaPremultiplied = true;

        var glyphs:Mesh = new Mesh(new PlaneGeometry(512, 512), glyphsMaterial);


        base.zOffset = 7777;
        splatter.zOffset = 8888;
        glyphs.zOffset = 9999;

        view.scene.addChild(base);
        view.scene.addChild(splatter);
        view.scene.addChild(glyphs);
    }

    private function onEnterFrame(e:Event):Void {
        view.render();
    }
}
