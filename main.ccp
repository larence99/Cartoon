
#include <iostream> 
#include <SFML/Graphics.hpp>
#include "Class.h"
#include "map.h"
using namespace sf;






int main()
{
	{
		RenderWindow window(sf::VideoMode(640, 700), "cartoon");

		
	
		Clock clock;

		Player walk("walk.png", 50, 70, 94.0, 145.0);//создаем объект walk класса player,задаем "walk.png" как имя файла+расширение, далее координата Х,У, ширина, высота.
		Player run("run.png", 500, 245, 94.0, 144.0);
		Player squats("squats.png", 100, 150, 86.0, 129.0);
		Player flag("flag.png", 300, 300, 121.0, 168.0);




		Image map_image;//объект изображения для карты
		map_image.loadFromFile("images/map.png");//загружаем файл для карты
		Texture map;//текстура карты
		map.loadFromImage(map_image);//заряжаем текстуру картинкой
		Sprite s_map;//создаём спрайт для карты
		s_map.setTexture(map);//заливаем текстуру спрайтом
		
		while (window.isOpen())
		{

			float time = clock.getElapsedTime().asMicroseconds();
			clock.restart();
			time = time / 800;


			sf::Event event;
			while (window.pollEvent(event))
			{
				if (event.type == sf::Event::Closed)
					window.close();
			}

			
			


			if (Keyboard::isKeyPressed(Keyboard::Space)) {
				
				walk.dir = 0; walk.speed = 0.1;
				walk.CurrentFrame += 0.005*time;
				if (walk.CurrentFrame > 6) walk.CurrentFrame -= 6;
				walk.sprite.setTextureRect(IntRect(103 * int(walk.CurrentFrame), 0, 100, 146)); //через объект walk класса player меняем спрайт, делая анимацию (используя оператор точку)
			}



			if (Keyboard::isKeyPressed(Keyboard::Space)) {
				run.dir = 1; run.speed = 0.2;
				run.CurrentFrame += 0.005*time;
				if (run.CurrentFrame > 6) run.CurrentFrame -= 6;
				run.sprite.setTextureRect(IntRect(104 * int(run.CurrentFrame), 0, 94, 102)); 
			}

			if (Keyboard::isKeyPressed(Keyboard::Space)) {
				squats.CurrentFrame += 0.005*time;
				if (squats.CurrentFrame > 2) squats.CurrentFrame -= 2;
				squats.sprite.setTextureRect(IntRect(90 * int(squats.CurrentFrame), 0, 86, 134)); 

			}

			if (Keyboard::isKeyPressed(Keyboard::Space)) {
				flag.CurrentFrame += 0.005*time;
				if (flag.CurrentFrame > 6) flag.CurrentFrame -= 6;
				flag.sprite.setTextureRect(IntRect(135 * int(flag.CurrentFrame), 0, 121, 168)); 

			}

			
			
			
			
			walk.update(time);//оживляем объект p класса Player с помощью времени sfml, передавая время в качестве параметра функции update. благодаря этому персонаж может двигаться
			run.update(time);//оживляем объект p класса Player с помощью времени sfml, передавая время в качестве параметра функции update. благодаря этому персонаж может двигаться
			squats.sprite.setPosition(50, 390);
			flag.sprite.setPosition(30, 537);
			
			window.clear();


			for (int i = 0; i < HEIGHT_MAP; i++)
				for (int j = 0; j < WIDTH_MAP; j++)
				{
					if (TileMap[i][j] == '1')  s_map.setTextureRect(IntRect(0, 0, 32, 32));
					if (TileMap[i][j] == ' ')  s_map.setTextureRect(IntRect(32, 0, 32, 32));
					if ((TileMap[i][j] == '0')) s_map.setTextureRect(IntRect(64, 0, 32, 32));
					if ((TileMap[i][j] == '2')) s_map.setTextureRect(IntRect(96, 0, 32, 32));
					if ((TileMap[i][j] == '3')) s_map.setTextureRect(IntRect(128, 0, 32, 32));
					if ((TileMap[i][j] == '4')) s_map.setTextureRect(IntRect(160, 0, 32, 32));
					if ((TileMap[i][j] == '5')) s_map.setTextureRect(IntRect(192, 0, 32, 32));


					s_map.setPosition(j * 32, i * 32);//по сути раскидывает квадратики, превращая в карту. то есть задает каждому из них позицию. 

					window.draw(s_map);
				}


			

		    window.draw(walk.sprite);//рисуем спрайт объекта walk класса player
			window.draw(run.sprite);
			window.draw(squats.sprite);
			window.draw(flag.sprite);
			window.display();
		}
	}
	return 0;
}
