Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCC4C9003
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338426; cv=pass; b=XqqeBqiN/5qrQjt28Dz8Ab725E1uVEDVFhO8wvVqZpCmEE9PwfPeyZucp4MBMOkCoxaqiivvHbNhdpVarbrdaqxC8Yv7CV957KOiI+LO3zIZkpJFkTCXCul/tnfOe9PdL4VI42S5mU39muyy4GW81jcY6r7UJvKTBg31KTMhroQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338426; c=relaxed/simple;
	bh=3BAdkEbGZqLfwXxKr2RxchaDtVa9lkmIZOkFm2/fWWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu1qtATW5YevRX5K0KB6WZi4E4gIvhNeZia9Y6oowNkIWZ1ISQGvyd+htmgDtUl4uKX7HDdzKjWwHDCrlTFg9M1omTu14cit6v+Hw2r5NEPDzxHaBSIjdaFj2K422cqA/rgGnU8aESZngKk96KN06mFlr28mLs7sv89kLFrrlTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3vsvpkg; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3vsvpkg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c15a5b265so355201cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 08:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785338424; cv=none;
        d=google.com; s=arc-20260327;
        b=LYPvkM3mSISxmXJ66QVaMduZA7o091vx35YT7MV23vl+vm6tibGWNIYcF6dv7oRyfC
         L7FY7lvDpTDqLaTiRCr9kLEfo/h+cubeaskeTzywmvElrdVrkcbkQPpc49UJ049yV2lK
         P20vYM3BZbKESvMBZDt50wZUweMaEERq5zH8t9Y8eUJFjD0lVAp97wzGwkJk7oY5FY0e
         lk2dS3hGt8Uuk3/qXY6XtGL9/AY4AWBraIoFfMOkQbXSsXm4YlfZWgEVDAQKXK3z9ttq
         KD30fSD/8WFG+TRv63me4t1ihPcf+PdGXgAwUpa0+OtEzLTDgXdZB/9ocsCSVpnIjmtD
         TrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JYgZt/35SRTSOby0/Cc9E+OqarqONJhII6K0Q/18dbI=;
        fh=LtpYi7H9NH/Blv1kAlfLyQVLK6tJarNVCrvXxVA4unA=;
        b=i8w5c2eYvTRkEMXcTZ/NNNoeW1sgA4a7nvs+SlIo2JU+snWzHGHj7PWqM8Yxtml1fm
         OqgvqzpSOCvO3xDLVs1S55qodWns5hbCBlSJE+K1DgfL9FE1XYHr3R6NT3e91Wbo+xSJ
         KOSAUr+fh49EY1IqS3SI4CgaxW52xZ19tmsWHZPI61OOFMMFjMrputTxzYnV6UiWRS9f
         TLFNI2Ll4GPvWlI/Aymd0ACEEIZOqaNaO4KQAmxWtBmX3wphl1LHPMpQgNPXKG6FL5uf
         1kq0l3filx7E9GFJnpl6IdLoJnmALNBM9bDxbsQw6cUijmtaQPlRMC3Jq23F7hdp65jp
         Tzmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785338424; x=1785943224; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYgZt/35SRTSOby0/Cc9E+OqarqONJhII6K0Q/18dbI=;
        b=L3vsvpkgRExvopHd3Qt3RNawb9DUgkDL/KKX2PkCuKGS8Yxs0qXVbCSwmHxm4wsfsE
         KAMAnlGqO182hQf5ZxMesMwuWlTiWd9kC+tmvCXMlixvmyqUDNv2G4TBgKyOLzu97ZFT
         SQcHFK2Bm+B0ChJk76n+G5GCodKjnI8z5KBcI8BQIrhcjPoRiHVIfcT0UfkLkTRLqul5
         nAeF6GBmAVao8/Y5y/2A3GDLkMDQ+9HeMSx4LYO/cbIq8yurfx1ZDSpg+PovsvJwt1G7
         QHXyj4JxqinzQKMprfJ+9ufVlMOin5/YqbnYwOEIlbkdBf1TYAgmh0X/SwGWY42t2jsA
         RdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338424; x=1785943224;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JYgZt/35SRTSOby0/Cc9E+OqarqONJhII6K0Q/18dbI=;
        b=kgigZsgg+/UMRnQP2db9zTVsbzjYBscw2UnCycgRF+hFyn00TonFYAeSAAAHXvzr2Z
         7OG7aA8inoiEBwjJ8yV4ouId56+XUZbdUL1rF4Sy7SUgbZjEd/bkBlOrGOD4FDtAEwPB
         nz0hZH+Ic0c44KPmWbEkFnhVqU8pkoAaxJAAIIhYZfCmC3qsTg6M0uqeZLKyezpFynNc
         D12qoAI4R4NLWQUs19KjZ0y8inwK3rAZG08FzKQfFFpH4BIXYnXoo9RT1PjAjK+k+jxX
         ICocp/C8qdAC8OOq728bQaxuP/xDWAyPD+w1uHqhbh3WRsdoCwIua1xTeNSjwKBHxINP
         IuuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBYFeslnRdfQnbiiCLB5p0D1GOHVeOj939LraiOb0nezgl0yEib+caBZHxCE7z5Kxo5DOgzBDch6nNpaMinoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8OZ4ShPKtimnNKvHqnERE4dkDFVp/HwCK1MKRKsF+qSzJaP4
	GEyRoKlnhcYNMI/snJx93ycx8IR2w5KRjeqWGgHSh+RcZ9XTdqms0DD/eMzjCCnvSa1VJA8kgmN
	5NJM5hOBaBw1/qBaQsXA2IKPDYtFNPr/HasqNV8hf
X-Gm-Gg: AR+sD10oZWBGyWiLqwfhB9n4BgL9O71qRvIe1kxo9br8hfB6ANz3K+NXAfQxI+RtPpo
	w63CNq9a3k2Z4yKK7EAp1SOYgle6x7Xa51h4Ud4AofiXs+zVmhlJ9wxcujfs5V5TFIXLL5xuY7P
	1vhZIz7TTk2HABde8BdVZWs60ivzwQjYnvqH9/+TzfjR3LoyaAZXRspPw0vZzaxT4ARI8lrGpM2
	yLwgpfQ54PKAj4tCMbDSFA1zawZhLBHhJcggSMozzyW0MGDXTatu3bf7ZwmzYOQc4thCIqDZJ2p
	+WQp4u/fYzhKH3JvISwHkdjgb2k0oH7uwOh0N2KelWDvveYZaQTEriILBZyjxY5vc2RgFx3UI8Z
	yVKKCQjnMgw==
X-Received: by 2002:a05:622a:9014:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52b34e95118mr803001cf.4.1785338408902; Wed, 29 Jul 2026
 08:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-3-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-3-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 29 Jul 2026 16:19:31 +0100
X-Gm-Features: AUfX_mwnVrQrZWbAViwhlMWDHtZtcw4flUU1g4ENMs-4TGfR7On64kQESsXcw8M
Message-ID: <CA+EHjTyYk0Dcc-8RbvQZHFBZ7HM7cekfg3O5MR4jo57qX5SohA@mail.gmail.com>
Subject: Re: [PATCH v9 03/16] KVM: arm64: PMU: Freeze counter count after
 first run
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> PMU configuration is VM-scoped, but SET_NR_COUNTERS can be issued
> through any vCPU. Checking only whether that vCPU's PMU has been
> initialized allows userspace to change the counter count through an idle
> sibling after another vCPU has run.
>
> Reject the attribute once any vCPU has run. This keeps the VM-wide
> implemented counter mask and the PMCR_EL0.N value stable after guest
> execution begins.
>
> Fixes: b7628c797376 ("KVM: arm64: Allow userspace to limit the number of PMU counters for EL2 VMs")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/pmu-emul.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index b5df6843dbcd..b4b877f31097 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -1087,6 +1087,9 @@ static int kvm_arm_pmu_v3_set_nr_counters(struct kvm_vcpu *vcpu, unsigned int n)
>  {
>         struct kvm *kvm = vcpu->kvm;
>
> +       if (kvm_vm_has_ran_once(kvm))
> +               return -EBUSY;
> +
>         if (!kvm->arch.arm_pmu)
>                 return -EINVAL;
>
>
> --
> 2.55.0
>
>
