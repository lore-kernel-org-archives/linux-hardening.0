Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221CC433EF
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Feb 2022 01:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356347AbiBDBOd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356255AbiBDBOb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 20:14:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220FC06173B
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 17:14:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so14187561ejc.7
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 17:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Rjor0jfBWADQNuiVXdyblMXrjJS5xpbSX0IQ1DxiWE=;
        b=cJCEYOrIPCkXtfM04ithN+EfN3tUV+/iGlKdmcBNa/388gx3roz9zW2nr0BIaELvuV
         0ZtpbQNzgnxW6t3PkLQfmC1bYmqCmasZMsKd+prnYlfjMy5maGVvlB/PK0c/yEtv/i46
         CkO9IV4hPMOsHo8HQgpRHwKsOCz5y3r9jChcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Rjor0jfBWADQNuiVXdyblMXrjJS5xpbSX0IQ1DxiWE=;
        b=MONqgE+TZT2r9nsTjWPWW6qYklLbxvrRorXHcOO2LJV8vIEKUP6NJMDtOrY/H8ahAW
         NgQ0EBZUNV9CNdGtzOQW0b7Mn9RDH7ZVQbEfq75wNa+gdBuSZFGDKjBWQ+1Uq7G7A99O
         IRE6nQyFcsiTXJleHmUfQfcRlyDfXiCLRAlVuszod4wCAtDdF3A2S48X2pvfQ4axBuBn
         vZzXBjmOSaWPWo/pgyaSzdMOgdqy/ePI3Ymot/FyWB1FOImXrxEp5c2hZGNihcrOpNGc
         oa0axbkOxUg0KixF+oIEdMCp0Ukw4ziAS0T8luJnvazfYPi2M0Mnn+MNy7aKVE+4/K5I
         Cxsg==
X-Gm-Message-State: AOAM532pRN41KCemivJmPZKgej8l69GXKvvNJm9d3DClD5MbzAVEfXzI
        Bb2/2gHA80bM+Gw5bOb0YYHK1mw+rtF6k/OR
X-Google-Smtp-Source: ABdhPJyjs8UiUZAd4UzBkvKfuGImPzjnIWWNpnxWEWQmOV/KhUw6GIk9HFYtDt/aAeMvouqmnLPf3Q==
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr448417ejn.497.1643937269168;
        Thu, 03 Feb 2022 17:14:29 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id w18sm207768edr.59.2022.02.03.17.14.27
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 17:14:28 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id s10so5803971wra.5
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 17:14:27 -0800 (PST)
X-Received: by 2002:a5d:500c:: with SMTP id e12mr414096wrt.193.1643937267127;
 Thu, 03 Feb 2022 17:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20220203201754.1145358-1-keescook@chromium.org>
In-Reply-To: <20220203201754.1145358-1-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Feb 2022 17:14:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj45HHNEvjKo-vNgFmCNtFW+rnQgmuBqhb9+eJ5pumvnQ@mail.gmail.com>
Message-ID: <CAHk-=wj45HHNEvjKo-vNgFmCNtFW+rnQgmuBqhb9+eJ5pumvnQ@mail.gmail.com>
Subject: Re: [PATCH v2] gcc-plugins/stackleak: Use noinstr in favor of notrace
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 3, 2022 at 12:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> While the stackleak plugin was already using notrace, objtool is now a
> bit more picky. Update the notrace uses to noinstr. Silences the
> following objtool warnings when building with:

Thanks, applied.

There are still a few objtool warnings about other issues, all look
somehow related to mce:

  mce_start()+0x5c: call to __kasan_check_write() leaves .noinstr.text section
  mce_gather_info()+0x5f: call to v8086_mode.constprop.0() leaves
.noinstr.text section
  mce_read_aux()+0x8a: call to mca_msr_reg() leaves .noinstr.text section
  do_machine_check()+0x197: call to mce_no_way_out() leaves
.noinstr.text section
  mce_severity_amd.constprop.0()+0xca: call to mce_severity_amd_smca()
leaves .noinstr.textp section

and from a quick look at least some of them look like real bugs.

For example, mce_read_aux() is marked 'noinstr', but it calls
mca_msr_reg() which is not. That's iffy.

The others might be compiler-generated (the 'constprop' thing has
caused section issues before so I didn't bother looking closer). Or
related to kasan. But at least one of them seems to be a valid warning
about bad behavior.

              Linus
