Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C1C63684
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiAZUhC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:37:02 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:58802 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiAZUhC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 15:37:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:50984)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nCp2K-005s7P-9x; Wed, 26 Jan 2022 13:37:00 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43320 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nCp2I-005myI-Cu; Wed, 26 Jan 2022 13:36:59 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220126175747.3270945-1-keescook@chromium.org>
        <CAG48ez3hN8+zNCmLVP0yU0A5op6BAS+A-rs05aiLm4RQvzzBpg@mail.gmail.com>
        <a89bb47f-677f-4ce7-fd-d3893fe0abbd@dereferenced.org>
        <CAG48ez3iEUDbM03axYSjWOSW+zt-khgzf8CfX1DHmf_6QZap6Q@mail.gmail.com>
        <202201261157.9C3D3C36@keescook>
        <YfGqLnE9wNieTsAg@casper.infradead.org>
        <202201261210.E0E7EB83@keescook>
Date:   Wed, 26 Jan 2022 14:31:16 -0600
In-Reply-To: <202201261210.E0E7EB83@keescook> (Kees Cook's message of "Wed, 26
        Jan 2022 12:13:16 -0800")
Message-ID: <87ilu6utm3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nCp2I-005myI-Cu;;;mid=<87ilu6utm3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Ur+F517FsWLf4Zd5izF0aDx++eGyOVhI=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] fs/binfmt_elf: Add padding NULL when argc == 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Jan 26, 2022 at 08:08:14PM +0000, Matthew Wilcox wrote:
>> On Wed, Jan 26, 2022 at 11:58:39AM -0800, Kees Cook wrote:
>> > We can't mutate argc; it'll turn at least some userspace into an
>> > infinite loop:
>> > https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
>> 
>> How does that become an infinite loop?  We obviously wouldn't mutate
>> argc in the caller, just the callee.
>
> Oh, sorry, I misread. It's using /bin/true, not argv[0] (another bit of
> code I found was using argv[0]). Yeah, {"", NULL} could work.
>
>> Also, there's a version of this where we only mutate argc if we're
>> executing a setuid program, which would remove the privilege
>> escalation part of things.
>
> True; though I'd like to keep the logic as non-specialized as possible.
> I don't like making stuff conditional on privilege boundaries if we can
> make it always happen.

Which I think means turning the argc == 0 case into { "", NULL }.
I think we can always do that, and it is already valid in userspace.

The only case I can imagine breaking would be an explicitly testing
for argc == 0 and behaving completely differently if that is passed
to the program.

Eric


