<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Record Result Modal -->
<div id="recordResultModal" class="fixed inset-0 z-[60] hidden">
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm transition-opacity"></div>
    <div class="fixed inset-0 z-10 overflow-y-auto">
        <div class="flex min-h-full items-center justify-center p-4">
            <div class="glass-card w-full max-w-md overflow-hidden rounded-3xl p-lg shadow-2xl transition-all scale-95 opacity-0 duration-300" id="recordResultContent">
                <div class="flex justify-between items-center mb-lg">
                    <h3 class="font-h3 text-h3 text-on-surface">Record Interview Result</h3>
                    <button onclick="closeRecordResultModal()" class="p-2 hover:bg-surface-variant/30 rounded-full transition-colors">
                        <span class="material-symbols-outlined">close</span>
                    </button>
                </div>
                
                <form action="company" method="post" class="space-y-md">
                    <input type="hidden" name="action" value="recordInterviewResult">
                    <input type="hidden" name="interviewId" id="record_interviewId">
                    <input type="hidden" name="applicationId" id="record_applicationId">
                    <input type="hidden" name="redirectView" value="interviews">

                    <div class="space-y-sm">
                        <label class="text-sm font-bold text-on-surface ml-1">Candidate</label>
                        <input type="text" id="record_studentName" disabled class="w-full bg-surface-container/50 border border-outline-variant rounded-xl p-md text-on-surface opacity-70">
                    </div>

                    <div class="space-y-sm">
                        <label class="text-sm font-bold text-on-surface ml-1">Interview Result</label>
                        <select name="result" id="interviewResultSelect" onchange="toggleNextRound(this.value)" required class="w-full bg-surface-container border border-outline-variant rounded-xl p-md text-on-surface focus:border-secondary focus:ring-1 focus:ring-secondary outline-none transition-all">
                            <option value="SELECTED">Selected (Final Hire)</option>
                            <option value="REJECTED">Rejected</option>
                            <option value="NEXT_ROUND">Selected for Next Round</option>
                        </select>
                    </div>

                    <div id="nextRoundDetails" class="hidden space-y-md">
                        <div class="space-y-sm">
                            <label class="text-sm font-bold text-on-surface ml-1">Next Round Name</label>
                            <input type="text" name="nextRoundName" placeholder="e.g. Technical Round 2, HR Round" class="w-full bg-surface-container border border-outline-variant rounded-xl p-md text-on-surface focus:border-secondary focus:ring-1 focus:ring-secondary outline-none transition-all">
                        </div>
                        
                        <div class="grid grid-cols-1 gap-md">
                            <div class="space-y-sm">
                                <label class="text-sm font-bold text-on-surface ml-1">Next Round Date & Time (Optional)</label>
                                <input type="datetime-local" name="nextRoundDate" class="w-full bg-surface-container border border-outline-variant rounded-xl p-md text-on-surface focus:border-secondary focus:ring-1 focus:ring-secondary outline-none transition-all">
                                <p class="text-[10px] text-on-surface-variant ml-1">Leave empty to only update round status without scheduling.</p>
                            </div>
                            
                            <div class="space-y-sm">
                                <label class="text-sm font-bold text-on-surface ml-1">Meeting Link (Optional)</label>
                                <div class="relative">
                                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-sm">link</span>
                                    <input type="url" name="nextMeetingLink" placeholder="https://meet.google.com/..." class="w-full bg-surface-container border border-outline-variant rounded-xl p-md pl-10 text-on-surface focus:border-secondary focus:ring-1 focus:ring-secondary outline-none transition-all">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="space-y-sm">
                        <label class="text-sm font-bold text-on-surface ml-1">Feedback / Notes</label>
                        <textarea name="feedback" required rows="3" class="w-full bg-surface-container border border-outline-variant rounded-xl p-md text-on-surface focus:border-secondary focus:ring-1 focus:ring-secondary outline-none transition-all resize-none" placeholder="Provide detailed feedback for the candidate..."></textarea>
                    </div>

                    <div class="flex gap-md pt-md">
                        <button type="button" onclick="closeRecordResultModal()" class="flex-1 border border-outline-variant py-3 rounded-xl font-button text-on-surface hover:bg-surface-variant/30 transition-all">Cancel</button>
                        <button type="submit" class="flex-1 bg-primary text-on-primary py-3 rounded-xl font-button shadow-btn hover:opacity-90 transition-all active:scale-[0.98]">Save Result</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function openRecordResultModal(interviewId, applicationId, studentName) {
    document.getElementById('record_interviewId').value = interviewId;
    document.getElementById('record_applicationId').value = applicationId;
    document.getElementById('record_studentName').value = studentName;
    
    const modal = document.getElementById('recordResultModal');
    const content = document.getElementById('recordResultContent');
    
    modal.classList.remove('hidden');
    setTimeout(() => {
        content.classList.remove('scale-95', 'opacity-0');
        content.classList.add('scale-100', 'opacity-100');
    }, 10);
}

function closeRecordResultModal() {
    const modal = document.getElementById('recordResultModal');
    const content = document.getElementById('recordResultContent');
    
    content.classList.add('scale-95', 'opacity-0');
    content.classList.remove('scale-100', 'opacity-100');
    
    setTimeout(() => {
        modal.classList.add('hidden');
    }, 300);
}

function toggleNextRound(val) {
    const container = document.getElementById('nextRoundDetails');
    if (val === 'NEXT_ROUND') {
        container.classList.remove('hidden');
    } else {
        container.classList.add('hidden');
    }
}
</script>
