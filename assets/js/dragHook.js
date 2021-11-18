import Sortable from 'sortablejs';

export default {
    mounted() {
        let dragged;
        const hook = this;
        const selector = "#" + this.el.id;

        document.querySelectorAll('.dropzone').forEach((dropzone) => {
            new Sortable(dropzone, {
                animation: 0,
                delay: 50,
                delayOnTouchOnly: true,
                group: 'shared',
                draggable: '.draggable',
                ghostClass: 'sortable-ghost',
                onEnd: (event) => {
                    hook.pushEventTo(selector, 'dropped', {

                        draggedId: event.item.id, // id of the dragged item

                        dropzoneId: event.to.id, // id of the drop zone where the drop occured

                        draggableIndex: event.newDraggableIndex, // index where the item was dropped (relative to other items in the drop zone)

                    });
                }
            });
        });
    }

    // All life-cycle methods
    // -----------------------
    // mounted - the element has been added to the DOM and its server LiveView has finished mounting
    // beforeUpdate - the element is about to be updated in the DOM.Note: any call here must be synchronous as the operation cannot be deferred or cancelled.
    // updated - the element has been updated in the DOM by the server
    // destroyed - the element has been removed from the page, either by a parent update, or by the parent being removed entirely
    // disconnected - the element's parent LiveView has disconnected from the server
    // reconnected - the element's parent LiveView has reconnected to the server
};