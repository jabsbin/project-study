class Animal:
    def move(self):
        print("움직인다")

class Dog(Animal):
    name = "개"
    
    def move(self):
        print(f"{self.name}는 궁디를 흔든다")

class Cat(Animal):
    name = "고양이"

    def move(self):
        print(f"{self.name}는 쌈바를 춘다")

class Wolf(Dog, Cat):
    pass

class Fox(Dog, Cat):
    def move(self):
        print("매혹한다")
    def foxMethod(self):
        print("매혹 날린다")

c1 = Dog()
c1.move()
c2 = Cat()
c2.move()
c3 = Fox()
c3.move()
print()

c = Animal()
c = c1
c.move()
print()
c = c2
c.move()
print()
c = c3
c.move()
