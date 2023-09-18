Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D371EC46CA1
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 12:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbjIRMUa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbjIRMU1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 08:20:27 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00E102
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 05:20:08 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a9ee3c7dbbso2923895b6e.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695039608; x=1695644408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ/RnGWVlYXjsYT2wHH8A/bPUFSgIF9iFkS7fZpZUgg=;
        b=YYqUufJuc0c2gUq3T4K/nNaVOlESAu+hSXbRk1FKOvjnEqS6+J1RcTPzhk9A0CsLEJ
         XjgM+Yx9yWe4c7w+dHUwa0hVcK5J+xTtfDqJArIYmIorjZU3YaXEg68IA6JWauofuApR
         Kb9Sl/nxMGDhzcKxMYF0n2KHvPuWcYOMmFIABPKpSmbJpFtUTPQT07dXIGvR2YT+6kZO
         4ezB9/kxW/qQc84ANG+kQuTR+v3UbY82jLHJ5PYpw/+0wj9xmoLTF9Tb6jH8sZR8rV3E
         OsE08NXE1ZdkmV+YdzRJ1wq5tvlcVoRYfoTsZycwpStjT0QQ81cGuUmHEsGg+yzrAgw9
         mLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039608; x=1695644408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJ/RnGWVlYXjsYT2wHH8A/bPUFSgIF9iFkS7fZpZUgg=;
        b=lLryr+BSR0X+XW7JF+zvHV/MoeP0xVl1aN5PV3mBJvMTW2Bz9OmURMd/RLjWqnAANU
         P3zpOlCRReIS99/6MXERuq9YiR61ef/bpr+fii24CAIP0U0XakEuvmujdAt0JLOqkHUl
         Nrjst+2rIbqXWA0z170tOLuBoYJBc0YRWY7gm/I51Q9XkxE6Sq2UzPcIcx8BmzTjqBiu
         4Fjxo8sxOQyirrIF15yzioAxKkN8xXpAqDq5PX4Y2P1KSopSsdi9izwjflI5KMui26XD
         RA0cy8vV/uvYC62jITk2SQB2n6TqcGwJpGJrxrN1NZyAQTFpPfI3q2ckBhPZn8ezTF3B
         8EfQ==
X-Gm-Message-State: AOJu0YwCY2pwi3DlC0KI4qQwigUWp2RS+/6S4f+B4hisM5+cEQNXq8kP
        VfJZKzvyID0+QV0qiN0TXVoi4S4bSywFNTL+VASVxQ6ss20NXK0gjNg=
X-Google-Smtp-Source: AGHT+IH4QInl/j5+gGf/Cu4Jd0o/JiZS8iO20fPzFtf4EWnwwCOCLo+sv7ujZymbloG1cGj+fly8h6Plt0tgKbwj9Mg=
X-Received: by 2002:a05:6870:d784:b0:1d6:5e41:a8a1 with SMTP id
 bd4-20020a056870d78400b001d65e41a8a1mr10689149oab.27.1695039607944; Mon, 18
 Sep 2023 05:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230916021835.never.147-kees@kernel.org>
In-Reply-To: <20230916021835.never.147-kees@kernel.org>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Mon, 18 Sep 2023 14:19:57 +0200
Message-ID: <CAHKB1wK5MPG8k2ij-bQLwES7Ytp0h2wE2jp5Cs6CJ3o_sOKDTg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Add SLAB_VIRTUAL knowledge
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 16 Sept 2023 at 04:18, Kees Cook <keescook@chromium.org> wrote:
>
> Add the markings for the SLAB_VIRTUAL area.
>
> Feel free to collapse this into the x86 patch from the above series.

Thanks! I will add it to the next revision of the series.

--
Matteo
