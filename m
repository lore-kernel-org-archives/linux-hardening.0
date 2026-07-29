Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADD411A02
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338612; cv=pass; b=oYYsbQF5rR8iQ/wZFgPWJBge3Ela3rAJc3cNedtyrHHdxyFaO9jt95KiIt2Dhe+fRgf12Rs+QRm7szqFFR98j8Ajh7xO7bXy1n6qzFySVh1uydEbUPs2Dj+OY7Rfj/Fc8dnWT+0IolJkmNK3QCY1ABefuor534QW9zNi+cmUlWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338612; c=relaxed/simple;
	bh=LVBzsbGMtEvkKYlB4ymkqikHz0oYkp14Iw5Po3+7C0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxaaXUD4cOwRwawrMwKwYc1kGCs32dR4X6An11dFZhQwW6G9d6SnG4e34RP1WyPO1s0JZxCIxz4In1DgV65XLArA6qMR6OXEXdd82e0acz8Bu4H26KWnvQwenDcVC/5B9FMLIelnDaJs2YWIKeVwQcUUn3n/iEOTwYuCqzKyfJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGp1RfGH; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGp1RfGH"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c15a5b265so356861cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 08:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785338609; cv=none;
        d=google.com; s=arc-20260327;
        b=Ys2gClFz8dGPHvRzeVWWbSlkXTnDAKMA7HPIHdOr+BmZwP/h1Pv1P2WIdgLAnVogZa
         82qRjIvIZgUePnYZqrTvc8Hr8/RIWPzdC3NAbgQ7k9OSlvbYFsV1CZ3Vz01y/Sr6niXX
         m5+4GBaiPI3Mb+u8mgH6Sbx7UdKxSQc/kwuYPVYx1iVdNYaiTaeWT+eXEYyyKC3mi7k9
         thR++VFlI2UqSzhUz3qFV1ehIt/L/oyejQpk5l8+vp36p/b9fScteMUxOa2Sl0p8/9P+
         ju+ARXSg2PvC7tDHC54W3XYSbRUbLmCMxoZAlRIWxXgdEu+Xaea4Esq/9nS5ouJAdkqt
         NVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EYpYlO78zITH6UjIoefobo5Po8cUwvLKaBgMucaKFtQ=;
        fh=w6+ExgUNx0We/z9t2vgAixqARk5EEme62aeJ7AXcxbI=;
        b=aIyT/chFO4mVMumUD77zxDw+a7CdQOcAwY7a5FzOwGM7xa7dgEtiVSYxXY93gEH5z6
         /duZnOMg2wfFfREDioww2vFUkzijz/yznbqDsGViVfbqH8ZIg2FwwisRo3r0vUOCjy0T
         opQp3+6k0OT+euZeZq5y3VzUidLlbePHaoez8uq9DWd1LDlqMoyPKp9IeLDblisY4hu4
         yhg31SCvWySXxi9bY/zpZ7tKqZJNGbTHAMIyJyASEVAN97WOZjY6rpd/+MdGVs+xwHQS
         NFvNxKFI7r2tfWE+vBnh6rTkJPR4F7dcLjtT+nsS7eQbYHo5pna2ZiwdJ6MUfAdv1Ao/
         /sYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785338609; x=1785943409; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYpYlO78zITH6UjIoefobo5Po8cUwvLKaBgMucaKFtQ=;
        b=aGp1RfGHDlZ0hE4muYzIy3nsHjllrhLfyxOgl9wIAwWgbWxY4eJL9CwgYJd3H9+CD/
         YqXHu9a+ynMSeJvf4Sc9dm8G66UZRRaP9FoSI1sC+9iwh7gZFG+8ama5NPrT7BeAKAju
         U+kjvu1B8GLGc0vIPfbyODcHWSfy0aldcQU/uuDkdtMnse9DkxBQ9j7Bk75Hx/QpYFYH
         TNvsOm3aW30rMhjPMXRWmldbn6RJQVT++j6SQmLngVlEexYmTQ0raoeZIcZelPhY7C1k
         wq+nm0wg42/YwUWOOQYY11QH3LzJeaUA8x7nP8Ehr+Hfs9XxGw+4MaRX5q7xAeUGSCH+
         mrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338609; x=1785943409;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EYpYlO78zITH6UjIoefobo5Po8cUwvLKaBgMucaKFtQ=;
        b=AihjVgRklYqIsG4LKQy50+LgvLOAtEjZHQAGYFZ+Y6Ml0dSbyFVWC4WlmLl2hGJuHD
         lMpdKV/9gSi5nl7M6R+mzplz8evBikxGXnuMSe//+s6U7qCSrtmNUj5cMgR0TBbk69mm
         qxfWnlppPYMeSRpUKPR87L33inIFJ0g4K/VYr2LSR1rAXJtQhNVaPUWbXCPoZHfSf7xM
         Ub3qHBgM/4s+Jx+WP3I3+ZbYUuwVvCLY+V/aeirynwZW61twnJFk3kXqPyppy4POzAeq
         Pw5nFYBDzx56HwZ+GBK3M21LkfwMdK+24a7zkQO9j3REy2LENo7FeGRSaJDBaNHhwD/E
         SPPg==
X-Forwarded-Encrypted: i=1; AHgh+RpQquPcWRCF0gWiRy9Hcuw0AVMxearxL5+B/z2imxHbbfq3LVF4NlNj6YKFhmnBK030uoQyMVLpC8fmYnuVPjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPmqgcYmfztS8vWe8nwR0GuspgT5F+/KvIyASQpNlKDxJwBl9
	Ies/6MDjXSwOdWFoxP6+qgWxzT0wK2UF5esQWqyluTbtA801K2z7XxhaDnFfwIv32SKdKvqn4Pl
	INmyT+d5AJW+WFp2r/jRjwT3oUi9IylMAXEfbokNr
X-Gm-Gg: AR+sD11NbzvQZHhxZZLEqG5U12ScLgQgN5pSSGgxXwr+eh4CI6nneml2ev4LtbULBUl
	3KaaNbk3kIRuuBUb/3qsDSoj4fiPQD46GPPe/U2I3Rl5XPNGpNXRQAPlOZwnP3e2zKG3ixzcsyx
	Xf84lDsB/Yjgx74ZsFv0Y2HT0dljint0mUmUod3fN+6P9Ne0NZGVSNSZbcFgI/cVTg2NO6rc7a9
	LE97MQU0sTVzH2+kuFocvVWnzngeoLovn3mxiIvyP7oJCzUaehMLKiair3O0HEx3Daql1tBout5
	p3DgldcTwoQwInBPGIDdXq/G/nUEF042q0+CEQWIpDIqoKdGpopKJDznj2rSFuKo2sc8QcphF8V
	S3bkWifmSlQ==
X-Received: by 2002:ac8:7c56:0:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-52b35089837mr565631cf.8.1785338608520; Wed, 29 Jul 2026
 08:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-4-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-4-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 29 Jul 2026 16:22:51 +0100
X-Gm-Features: AUfX_mwUs9MTXlZgLAxa7rxOqn4AEWfpGlzGWJmBR-6Vw5CXw5g4z3qo-EMbdA0
Message-ID: <CA+EHjTzwDrP=3a7f38e2H_H1YPV0igRryhfuNCigZQUFy02tng@mail.gmail.com>
Subject: Re: [PATCH v9 04/16] KVM: arm64: selftests: Test SET_NR_COUNTERS
 after first run
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

On Mon, 20 Jul 2026 at 06:44, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Add a regression test that runs one vCPU and then tries to change the
> VM-scoped PMU counter count through an idle sibling. Verify that
> SET_NR_COUNTERS fails with EBUSY once any vCPU has run.
>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  .../selftests/kvm/arm64/vpmu_counter_access.c      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> index 22223395969e..3b5bb421f401 100644
> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> @@ -461,6 +461,11 @@ static void run_vcpu(struct kvm_vcpu *vcpu, u64 pmcr_n)
>         }
>  }
>
> +static void guest_code_done(void)
> +{
> +       GUEST_DONE();
> +}
> +
>  static void test_create_vpmu_vm_with_nr_counters(unsigned int nr_counters, bool expect_fail)
>  {
>         struct kvm_vcpu *vcpu;
> @@ -622,6 +627,37 @@ static bool kvm_supports_nr_counters_attr(void)
>         return supported;
>  }
>
> +static void test_set_nr_counters_after_vcpu_run(void)
> +{
> +       struct kvm_vcpu *running_vcpu, *stopped_vcpu;
> +       unsigned int nr_counters = 0;
> +       struct kvm_vcpu_init init;
> +       struct kvm_vm *vm;
> +       int ret;
> +       u64 irq = 23;
> +
> +       vm = vm_create(2);
> +       vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> +       init.features[0] |= BIT(KVM_ARM_VCPU_PMU_V3);
> +       running_vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code_done);
> +       stopped_vcpu = aarch64_vcpu_add(vm, 1, &init, guest_code_done);
> +       kvm_arch_vm_finalize_vcpus(vm);
> +
> +       vcpu_device_attr_set(running_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                            KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
> +       vcpu_device_attr_set(running_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                            KVM_ARM_VCPU_PMU_V3_INIT, NULL);
> +       vcpu_run(running_vcpu);
> +
> +       ret = __vcpu_device_attr_set(stopped_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                                    KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS,
> +                                    &nr_counters);
> +       TEST_ASSERT(ret == -1 && errno == EBUSY,
> +                   KVM_IOCTL_ERROR(KVM_SET_DEVICE_ATTR, ret));
> +
> +       kvm_vm_free(vm);
> +}
> +
>  int main(void)
>  {
>         u64 i, pmcr_n;
> @@ -630,6 +666,8 @@ int main(void)
>         TEST_REQUIRE(kvm_supports_vgic_v3());
>         TEST_REQUIRE(kvm_supports_nr_counters_attr());
>
> +       test_set_nr_counters_after_vcpu_run();
> +
>         pmcr_n = get_pmcr_n_limit();
>         for (i = 0; i <= pmcr_n; i++) {
>                 run_access_test(i);
>
> --
> 2.55.0
>
>
