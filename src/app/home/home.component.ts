import { NgFor, NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
    selector: 'home',
    imports: [FormsModule, NgFor, NgIf],
    templateUrl: './home.component.html',
    styleUrl: './home.component.css'
})
export class HomeComponent {
    title: string = "wide3";
    knowledge: string = '';
    messages: any[] = [];

    public onKnowledgeKeydown(event: KeyboardEvent): void {
        if (event.key === 'Enter' && !event.ctrlKey) {
            event.preventDefault()
            console.log(this.knowledge);
            this.messages.push({ message: this.knowledge, user: true });
            this.messages.push({ message: "Questa è una risposta", user: false });
        }
    }
}
