Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B836BC43217
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 16:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLAQq3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLAQqT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 11:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044AAFCD7
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669913121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0j7iDCqKcud61bnCVouYTAjXYx/lMBjTVmeuK6IwiIs=;
        b=JE7etUm8egdxRXYUhmANPa02iyKHHiOlaXYXU/pbuE3kcQYXSpuzw1A3faA5nKKIMLCJqX
        Ilb0MVni/neJgL43rrQ8bGljrwRAzoc59Ye15Xp6F5W1/JHk9fz+BS7psAGSgsXsdA2ErI
        W6fSo4DCu/3DN+ITUNo2dNQc5V9Bq6c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-8GSeE8kANBOWn7wNWUAqJw-1; Thu, 01 Dec 2022 11:45:18 -0500
X-MC-Unique: 8GSeE8kANBOWn7wNWUAqJw-1
Received: by mail-ej1-f72.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so1660944ejc.11
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 08:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j7iDCqKcud61bnCVouYTAjXYx/lMBjTVmeuK6IwiIs=;
        b=wlQtfcjF+XxbdokpPy78CIsDHnqef4Eh9hU8y9dPPo8RYET9fVhMEFjTktDJF/Bjli
         t9zwnlZSTcBmkt3vny/tYJ4FtZnLkpRIRRHFHdcTrO2i+Xw5/rGaXEbbifPYE5G4hww7
         Kgk7t4HuZGMFsK2GYxP9QYeV9Me25bGF9+m4Ii62UasiVmQ0FXemu/Y+KjFcIaLO+crg
         FUmh+cKrRduSsK8xz15SAEF6jhcVTnBtcfEYg/+vGBfzf0G/fV1+8rGwjcnHeBKANAoo
         4EZZNK0E4AO9cjHBqpiVr1oax9UHLnyXHI21tfhK+wK+H2DHoqPlwkTKl5JLC4tt9eBZ
         LBeQ==
X-Gm-Message-State: ANoB5pm4YoC0cyEFaEezZymaq1LTWYKhJyikkJ1Rke9HKH8TXrOYabEy
        xkUCQza0aqVK+irRwFb6FY+ASpf+mnXWVlTbHZ7fm6uNip50e+q+nXLP2TmxXRulfIwAsCO69Fn
        XSep/JpGw7fXCctJgIWczcG9iojy8RvMI7BGagYnvN/uvzq364nkGRi+riBN6Wl9GtGsnBAhItp
        AhPEJr
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr47970160ejb.47.1669913117118;
        Thu, 01 Dec 2022 08:45:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eaU/O5iQxd1YPRfrkTQE4uquPar9KRJcIbFIa3jXZVSj/nGj010qrX05SJquNTJ1RK03UPA==
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr47970132ejb.47.1669913116866;
        Thu, 01 Dec 2022 08:45:16 -0800 (PST)
Received: from ovpn-194-141.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402050b00b00467cc919072sm1917760edv.17.2022.12.01.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:45:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     coverity-bot <keescook@chromium.org>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: kvm_hv_flush_tlb(): Uninitialized variables
In-Reply-To: <202212010825.9FB75F1F@keescook>
References: <202212010825.9FB75F1F@keescook>
Date:   Thu, 01 Dec 2022 17:45:14 +0100
Message-ID: <87edtjf4yt.fsf@ovpn-194-141.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

coverity-bot <keescook@chromium.org> writes:

> Hello!
>
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221201 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Fri Nov 18 12:59:05 2022 -0500
>     260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
>
> Coverity reported the following:
>
> *** CID 1527764:  Uninitialized variables  (UNINIT)
> arch/x86/kvm/hyperv.c:2024 in kvm_hv_flush_tlb()
> 2018     		 * Hyper-V TLFS doesn't explicitly forbid non-empty sparse vCPU
> 2019     		 * banks (and, thus, non-zero 'var_cnt') for the 'all vCPUs'
> 2020     		 * case (HV_GENERIC_SET_ALL).  Always adjust data_offset and
> 2021     		 * consumed_xmm_halves to make sure TLB flush entries are read
> 2022     		 * from the correct offset.
> 2023     		 */
> vvv     CID 1527764:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "data_offset".
> 2024     		data_offset += hc->var_cnt * sizeof(sparse_banks[0]);
> 2025     		consumed_xmm_halves += hc->var_cnt;
> 2026     	}
> 2027
> 2028     	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
> 2029     	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||
>
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):

Looks half legit) 'data_offset' can only be uninitialized here in
'hc->fast' case but this also means that the only user of 'data_offset'
(kvm_hv_get_tlb_flush_entries()) below will not use it. So yes, we do
increment an uninitialized variable but we won't use the result. I think
we're better off fixing this, even if there's no real issue. I'll send a
patch, hopefully tomorrow.

Thanks!

>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527764 ("Uninitialized variables")
> Fixes: 260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
>
> Thanks for your attention!

-- 
Vitaly

