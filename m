Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A46C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 18:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbiBJSR7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:17:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245650AbiBJSR6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Feb 2022 13:17:58 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244EC4B;
        Thu, 10 Feb 2022 10:17:59 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:41096)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIE10-00AGdg-LX; Thu, 10 Feb 2022 11:17:58 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41388 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIE0z-00Dbz8-QO; Thu, 10 Feb 2022 11:17:58 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220210025321.787113-1-keescook@chromium.org>
Date:   Thu, 10 Feb 2022 12:17:50 -0600
In-Reply-To: <20220210025321.787113-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 9 Feb 2022 18:53:18 -0800")
Message-ID: <871r0a8u29.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nIE0z-00Dbz8-QO;;;mid=<871r0a8u29.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0ElVN4jF3VxNbNbK8Cp+alPjWl5IMXlo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Hi,
>
> This fixes the signal refactoring to actually kill unkillable processes
> when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
> report and Eric for the fix! I've also tweaked seccomp internal a bit to
> fail more safely. This was a partial seccomp bypass, in the sense that
> SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
> aspects of the filters. (i.e. the syscall was still blocked, etc.)

Any luck on figuring out how to suppress the extra event?
>
> I'll be sending this to Linus after a bit more testing...
>
> Thanks,
>
> -Kees
>
> Kees Cook (3):
>   signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
>   seccomp: Invalidate seccomp mode to catch death failures
>   samples/seccomp: Adjust sample to also provide kill option
>
>  kernel/seccomp.c          | 10 ++++++++++
>  kernel/signal.c           |  5 +++--
>  samples/seccomp/dropper.c |  9 +++++++--
>  3 files changed, 20 insertions(+), 4 deletions(-)

Eric
