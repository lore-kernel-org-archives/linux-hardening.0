Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7515EC4363A
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D122247
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 20:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409401AbgJTUUV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:20:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59064 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409400AbgJTUUV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 16:20:21 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kUy7G-0000NA-O6
        for linux-hardening@vger.kernel.org; Tue, 20 Oct 2020 20:20:18 +0000
Received: by mail-ej1-f70.google.com with SMTP id u7so3157ejb.4
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2020 13:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvOvrqIowXTqWbDC3SiYk9DLPVZO2oaMjHYKa1wNVGk=;
        b=Ym99ZBrJoCO87yRF7CxETJhPJ84NhVNhTxiVTC03vklNFivMo6En3EcRqike/xBPgv
         OvzRkvgzf2I5YvWA8lhbCc/NatqmIpT03jaGWOqGbmFxLFH3kvJFKqn0JMaIXv0oazBm
         f9NqBOEjTE4xLd0bxESMtqTPUY8crRsM2JrSpmd36FGhNC8dASlx3JwuIKOXuhXOEARn
         An68O0ioWruFCf3tgdAeXJYsgUrsWqn0Id+Ia0paDavPR3boa5pLzY7kmgosmxzcVWAS
         wiUf5qhteRUOqwwAl6tH/Fem5SwaS2QlpArvCZFfVm3t0SpzZkY8MD4lOZTwXup576Fp
         08Ow==
X-Gm-Message-State: AOAM532m/byq+SJXycNE48Wq8vlF3AyDPVe38b1jyoUF2n4LMGEckv64
        NuWc1OpaiKr8tFb5wgW9M9mv7aW+6KfeASFaCK9kS4cQNeNiohi+bRcKMDP5vOat3G0+mwag18z
        EMUT8Fv/0kjrIuW+GARHQ/ARnz0Wxu9boTopp+gWXZCLqOXGgsK8XMkKFNfh7Mw==
X-Received: by 2002:a17:907:2079:: with SMTP id qp25mr5120225ejb.347.1603225218450;
        Tue, 20 Oct 2020 13:20:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqbbW8pMrleDlOJd1KePFqq+CJbaQMJ+psyTG1mR8nQ4SwdBtFh6Yuwue0V+iAwXeGPL4ShGlaEgzeY9wHMIY=
X-Received: by 2002:a17:907:2079:: with SMTP id qp25mr5120206ejb.347.1603225218228;
 Tue, 20 Oct 2020 13:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201019182853.7467-1-gpiccoli@canonical.com> <20201020082022.GL27114@dhcp22.suse.cz>
 <9cecd9d9-e25c-4495-50e2-8f7cb7497429@canonical.com> <5650dc95-4ae2-05d3-c71a-3828d35bd49b@redhat.com>
In-Reply-To: <5650dc95-4ae2-05d3-c71a-3828d35bd49b@redhat.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 20 Oct 2020 17:19:42 -0300
Message-ID: <CAHD1Q_wQrnSEGOvbCi0uhHZ5bRf=inzPdOhGKJ9PkVms5GSWRA@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: Avoid double clearing for hugetlb pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Alexander Potapenko <glider@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When I first wrote that, the design was a bit different, the flag was
called __GFP_HTLB_PAGE or something like that. The design was to
signal/mark the composing pages of hugetlb as exactly this: they are
pages composing a huge page of hugetlb "type". Then, I skipped the
"init_on_alloc" thing for such pages.

If your concern is more about semantics (or giving multiple users,
like drivers, the power to try "optimize" their code and skip this
security feature), I think my first approach was better! This way, the
flag would be restricted to hugetlb usage only.
I've changed my mind about that approach before submitting for 2 reasons:

(a) It feels a waste of resources having a GFP flag *only* to signal
regular pages composing hugetlb pages, it's a single user only,
forever!
(b) Having 2 conditional settings on __GFP_BITS_SHIFT (LOCKDEP and
HUGETLB) started to make this define a bit tricky to code, since we'd
have 2 Kconfig-conditional bits to be set.

So, I've moved to this other approach, hereby submitted.
Cheers,


Guilherme
