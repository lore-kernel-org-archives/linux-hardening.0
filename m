Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CEEC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 18:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbiBJS6P (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:58:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiBJS6P (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Feb 2022 13:58:15 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB810B7;
        Thu, 10 Feb 2022 10:58:15 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:47730)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIEdy-00AOdS-VC; Thu, 10 Feb 2022 11:58:15 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42386 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIEdx-00DkzX-P8; Thu, 10 Feb 2022 11:58:14 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220210025321.787113-1-keescook@chromium.org>
        <871r0a8u29.fsf@email.froward.int.ebiederm.org>
        <202202101033.9C04563D9@keescook>
Date:   Thu, 10 Feb 2022 12:58:07 -0600
In-Reply-To: <202202101033.9C04563D9@keescook> (Kees Cook's message of "Thu,
        10 Feb 2022 10:41:57 -0800")
Message-ID: <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nIEdx-00DkzX-P8;;;mid=<87pmnu5z28.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JrQ7YMIrXD3csaWAuHpMyqCe9x5AzMzo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Feb 10, 2022 at 12:17:50PM -0600, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > Hi,
>> >
>> > This fixes the signal refactoring to actually kill unkillable processes
>> > when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
>> > report and Eric for the fix! I've also tweaked seccomp internal a bit to
>> > fail more safely. This was a partial seccomp bypass, in the sense that
>> > SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
>> > aspects of the filters. (i.e. the syscall was still blocked, etc.)
>> 
>> Any luck on figuring out how to suppress the extra event?
>
> I haven't found a good single indicator of a process being in an "I am dying"
> state, and even if I did, it seems every architecture's exit path would
> need to add a new test.

The "I am dying" state for a task is fatal_signal_pending, at least
before get_signal is reached, for a process there is SIGNAL_GROUP_EXIT.
Something I am busily cleaning up and making more reliable at the
moment.

What is the event that is happening?  Is it
tracehook_report_syscall_exit or something else?

From the bits I have seen it seems like something else.

> The best approach seems to be clearing the TIF_*WORK* bits, but that's
> still a bit arch-specific. And I'm not sure which layer would do that.
> At what point have we decided the process will not continue? More
> than seccomp was calling do_exit() in the middle of a syscall, but those
> appear to have all been either SIGKILL or SIGSEGV?

This is where I get confused what TIF_WORK bits matter?

I expect if anything else mattered we would need to change it to
HANDLER_EXIT.

I made a mistake conflating to cases and I want to make certain I
successfully separate those two cases at the end of the day.

Eric

