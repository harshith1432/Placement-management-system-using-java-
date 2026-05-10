<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Schedule Interview Modal -->
<dialog id="scheduleModal" class="rounded-2xl p-0 backdrop:bg-on-surface/20 backdrop:backdrop-blur-sm shadow-2xl w-full max-w-md">
    <div class="p-lg">
        <div class="flex justify-between items-center mb-lg">
            <h3 class="font-h3 text-h3">Schedule Interview</h3>
            <button onclick="document.getElementById('scheduleModal').close()" class="material-symbols-outlined">close</button>
        </div>
        <form action="company" method="post" class="space-y-md">
            <input type="hidden" name="action" value="scheduleInterview">
            <input type="hidden" name="applicationId" id="schedule_appId">
            <input type="hidden" name="redirectView" id="schedule_redirectView" value="applicantReview">
            
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Candidate</label>
                <input type="text" id="schedule_studentName" class="w-full rounded-lg border-outline-variant bg-surface-container/50 font-semibold" readonly>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Interview Round</label>
                <input type="text" name="roundName" placeholder="e.g. Technical Round 1" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Date & Time</label>
                <input type="datetime-local" name="dateTime" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Meeting Link</label>
                <input type="url" name="meetingLink" placeholder="Google Meet / Zoom URL" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Notes</label>
                <textarea name="notes" rows="3" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" placeholder="Any specific instructions for the candidate..."></textarea>
            </div>
            
            <div class="pt-lg">
                <button type="submit" class="w-full bg-secondary text-on-secondary py-sm rounded-xl font-button shadow-md hover:opacity-90">Confirm Schedule</button>
            </div>
        </form>
    </div>
</dialog>

<script>
    function openScheduleModal(appId, name, redirectView = 'applicantReview') {
        document.getElementById('schedule_appId').value = appId;
        document.getElementById('schedule_studentName').value = name;
        document.getElementById('schedule_redirectView').value = redirectView;
        document.getElementById('scheduleModal').showModal();
    }
</script>
