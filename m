Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3830C47093
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F63613AF
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 08:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhFAIWw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233300AbhFAIWv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 04:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622535670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WReHxPda64zFpH85OA/SFzugrU65pXg0epyJmDyWUw0=;
        b=f6XYq47cbbFLcXqPzOE9r8Fh8e9eRijY5OubdTZ1kw38Qcdg3DffqgA2HDJTUOFf4mnWgv
        oqtU0hjRNr7OXs9xntiBmlKhTupaqq1w2rC9jBTN8lF/Ktu9w3SK0EM4VfZDofpNgQLBwO
        AUi7SFQzzo0388MUMpOUyVgUeu6jYTQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-62_bYEezMuu6aj4PyQ9Osg-1; Tue, 01 Jun 2021 04:21:06 -0400
X-MC-Unique: 62_bYEezMuu6aj4PyQ9Osg-1
Received: by mail-ej1-f70.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso3034979ejn.10
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 01:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WReHxPda64zFpH85OA/SFzugrU65pXg0epyJmDyWUw0=;
        b=Bj/lGF47dDXqW/MImd4mo2xtK408qdQOZxN6s0eifPOYupsIZVzxSdZ7xH2P3EuWK5
         TbIRNLRQMKp2NDMONugyaD5rE9PW0qKhvkiq03+NyVkiaH3N6cGRCKxh3vT6w81bKdFZ
         E+Ca+u9B4I7Z6pTHgz7i1MkV74pTgVh2EPv1EoQ3TjswUBTt2FB8L9GcVb2jow3FUos/
         NKFhwKKHo/JKBGMZq5uvt+S45yNktaAF/d1GIpg3Y7Nae9IIn/OWyMR6Tums7q0gfgLp
         KqFixozuEj44Oo+oVP887fOg4VRXFm8ebRoouWiPmfK+9H2/hGAgYKpIDrIQ5yCs7h/1
         92Dg==
X-Gm-Message-State: AOAM5312ZgTSQM2BF79kbvVWds1nUZ007m5Qz+bfJsbV/uKXQiLl3cWj
        hf9Qe6HBlnGCLn0uNP7WvSe2g1+sLARiQXHbFkYWHjSp1ei6V3UwvllppCqU2PtwiyV9uLmJqiv
        W8C275Y/lpY5iACpbEixS+Kz+6lElYrzmNQYVK7b4fcQxdvFYInRZzd21KE13pgLyM3fIES1r7W
        +X7xTe
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr31049697eds.291.1622535664497;
        Tue, 01 Jun 2021 01:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGx4WjZajKzfRVdcO3xdPUBoEbwZ8YN5yKtU7CehhauQj/wnCqLYgCI87BDDuWg2PYcGjN8w==
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr31049665eds.291.1622535664323;
        Tue, 01 Jun 2021 01:21:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lv10sm7146890ejb.32.2021.06.01.01.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:21:03 -0700 (PDT)
Subject: Re: [PATCH][next] KVM: x86: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210528200756.GA39320@embeddedor>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1624e6f-1ca0-ac57-29c0-05d7c944ffc7@redhat.com>
Date:   Tue, 1 Jun 2021 10:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528200756.GA39320@embeddedor>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 28/05/21 22:07, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding break statements instead of just letting
> the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>        to just 25 in linux-next. These are some of those last remaining
>        warnings.
> 
>   arch/x86/kvm/cpuid.c   | 1 +
>   arch/x86/kvm/vmx/vmx.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 9a48f138832d..b4da665bb892 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -655,6 +655,7 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>   		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
>   			entry->ecx = F(RDPID);
>   		++array->nent;
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4bceb5ca3a89..e7d98c3d398e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6248,6 +6248,7 @@ void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
>   	switch (kvm_get_apic_mode(vcpu)) {
>   	case LAPIC_MODE_INVALID:
>   		WARN_ONCE(true, "Invalid local APIC state");
> +		break;
>   	case LAPIC_MODE_DISABLED:
>   		break;
>   	case LAPIC_MODE_XAPIC:
> 

Queued, thanks.

Paolo

