Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAC4EE49AF
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Aug 2023 23:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHVXp1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHVXp0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Aug 2023 19:45:26 -0400
Received: from mail-pf1-x462.google.com (mail-pf1-x462.google.com [IPv6:2607:f8b0:4864:20::462])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F46E4A
        for <linux-hardening@vger.kernel.org>; Tue, 22 Aug 2023 16:45:24 -0700 (PDT)
Received: by mail-pf1-x462.google.com with SMTP id d2e1a72fcca58-68a56401c12so1870180b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 22 Aug 2023 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692747923; x=1693352723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoJziu4hpqNirsaTxxJF0jjBD2lwvBdbeYwFFzOMNgE=;
        b=NE8EzPqXpcVm81gfigYwJcy6TQG8fD79BTNxsGe2QLtbo5aPQ/lcq2OjAX+rldweg/
         1/tHlhUjDhhxw074PkrRd0GXQVKq1hnZd2LVQ/VcIH1Rt27eL18Med9gFKr2YJ3UOI2S
         vhfDRsgI0Zla8M2LANL+WcUoUTj3KyWG1LzcL8zCDjzFonwhUOpNqNcxaC5d5AjYiDNh
         qhHTobgF5Q7+duo9h7IMAivpfiiAfBOJFDk66afaGqc5652B9OPEgkpVnEy8HkVTpEB/
         p6y86WiHWhsyA85ysk2g2q9pV6Uu8XjABL0Set6DVie4Gzno1nJP+PGz9LfKep0fYnCH
         MCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747923; x=1693352723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoJziu4hpqNirsaTxxJF0jjBD2lwvBdbeYwFFzOMNgE=;
        b=MHupNYgQFMfrq1QMkLwEF+lkBt6nhZSl6MbI2MgA6Lw1MCECK5XESJoNFXYcv44mG1
         NjC7QMR4ELHNvuBbMAqXIqsqQDsb++3Ec+dq+uCn9ASCcSTMIISnR9QXdKj+iFljXpi7
         8puxOemt1uqP5CLbauOUxIS8blZazI6iy8guK3gfr0QcOPp/DnWsVX4AiFhx9iFINljz
         jqMpIY9rzyDgj8fwu393uLHn00Sz8oAMlOzcHI3Ub1P0eTqqubNSp6X3S0xdbQgOYIsE
         wIZroD+rHQFfnhhCv1hlD1vaARoYM96f9sMQVZwBah6UddnTTUGvDlWZ/1USuAkxSn5u
         BolA==
X-Gm-Message-State: AOJu0YwrBGGYYlYAtsSBKkzIZuHwNtvhiSKajkkhias1VHGN+b8NPi0L
        6BsIJ9Y/3endU9+R/7QBZeJUj7fCjIZDzXqx6Jr0EdSrkrJB0qzI4YXjOHSfeRm/lA==
X-Google-Smtp-Source: AGHT+IFwbvX86nPDwHG5Njs0zik/dlcDU9BNw1GpeAYb0xXjTXOctyZNMxM7HWb3l+Tjbhpz4ngX+BLuDRH3
X-Received: by 2002:a05:6a21:4847:b0:148:6ebd:2834 with SMTP id au7-20020a056a21484700b001486ebd2834mr7007249pzc.34.1692747923532;
        Tue, 22 Aug 2023 16:45:23 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id a186-20020a624dc3000000b0068718f530c5sm1324762pfb.16.2023.08.22.16.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2023 16:45:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 4320621FC8;
        Tue, 22 Aug 2023 17:45:22 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id 3CB70E42F97; Tue, 22 Aug 2023 17:45:22 -0600 (MDT)
Date:   Tue, 22 Aug 2023 17:45:22 -0600
From:   Uday Shankar <ushankar@purestorage.com>
To:     =?utf-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
Message-ID: <20230822234522.GA2590891@dev-ushankar.dev.purestorage.com>
References: <20230822010933.2247671-1-ushankar@purestorage.com>
 <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOQodU1CNMRtjYZ6@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOQodU1CNMRtjYZ6@cork>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 21, 2023 at 08:16:05PM -0700, Jörn Engel wrote:
> On Tue, Aug 22, 2023 at 09:56:38AM +0800, Huang, Ying wrote:
> > 
> > ERST is mainly used to log the hardware error.  While, hardware error
> > may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
> > ERST functions in NMI handlers.  Where normal spinlock cannot be used
> > because they will be converted to sleepable rt_mutex in RT kernel.
> 
> Non-sleeping spinlocks cannot be used in NMI context either.
> raw_spin_lock_irqsave() will prevent regular interrupts, but not NMI.
> So taking a spinlock inside an NMI can trigger a deadlock.
> 
> Am I missing something here?
> 
> Jörn
> 
> --
> All art is but imitation of nature.
> -- Lucius Annaeus Seneca

Also want to point out that both before and after this commit, we only
use trylock from erst_write, which looks like the only function touched
by this patch which can be called from NMI context. Trylock should be
safe in NMI context regardless of the type of synchronization used
(raw_spinlock, spinlock, or otherwise).
