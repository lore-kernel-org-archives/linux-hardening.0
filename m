Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087733B27F7
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394385; cv=none; b=OnLAT/9RYKGzgwEgReHAk9e1KwluvZcmtB1h0cmHmUCq9zE7qY/HcVXFQ7Guo2w9TZdf9Yk1ixkvHXLDPOk0kYE77NrNYWIWzS/aMhhBTtD+pIwSLJ037wjemfVcaXalnLj/ZmJ4TRSAtudfmluccm34kXhlqp1XFHjf3eBvpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394385; c=relaxed/simple;
	bh=Pbj0P+gU8va8jJCrhk4MN1M1pVJoePTsLFgY9CKEP0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emgeR6N5XANUdSkGcaS46cfDw1CABzdhEnVqLOJ6EcNpRIkl7rc3BjxN9qiD1bnfSZM9wZjhoNaX/N/ifaiYTXvbaOu/Ki5BORkGvSH6lW2ZCIqvkLvxp0MsSWjNcjalq73QW/qGcs9PwQZVTFnM4UDsOh0BnneCdk1jiIJbrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xcdxm9OQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xcdxm9OQ"
X-Forwarded-Encrypted: i=1; AHgh+RrIQDffdLzqBVhXvvlUdWhSwfRGFOY9nk68bQnlopFHM6KR606AhpY27cdPLgfm5Vr7ff+RIRFh7HSZ0Fbu2I0=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785394379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pbj0P+gU8va8jJCrhk4MN1M1pVJoePTsLFgY9CKEP0E=;
	b=Xcdxm9OQ8Eu+n1D7cDArgW3qzsmUFyciXadQnUjihQavB54Dz/AGYfwQ6iyWFsR47l0gV7
	sUz0Xmut4ByvpyMmpQWfuF82EBdpzDWRyI6c7t0kWPMvA3NyPZTKQEkWDYnb0vK0+ScKt2
	etE8IHS5lf8ur6/nQdU//RSb6Qpf67A=
X-Gm-Message-State: AOJu0Yz9Wp7YvVo71pdEnU3Lnyld4ZYb7/lGehMEjrEymucfvWPuU1h7
	vVpD/RDMLRtSbZLAdcTG5jgS4MD0il07vZzsL9QaqjSneKJgZEzf06eUR7IaZOcfHKfkNZEORQa
	xPPK7AIZG0gC3bR85JPvLqgnWvA+D4LdCREeTVhN8
X-Received: by 2002:a05:622a:1f18:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52b39484e98mr9124391cf.11.1785394358893; Wed, 29 Jul 2026
 23:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
 <20260720-hybrid-v9-14-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
 <CA+EHjTx0zNQ_yPCz38vGYpBssshE4b3KWaoUxjzuerGgzB=JSQ@mail.gmail.com> <e023d791-38c3-47b4-9b09-3420fe78d9ea@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <e023d791-38c3-47b4-9b09-3420fe78d9ea@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 30 Jul 2026 07:52:01 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxAH-eW4soxjbSJi8DwbH-yRXE-jJ9s02nEZ7kVXxxWMQ@mail.gmail.com>
X-Gm-Features: AUfX_my8ZWlfDB9plrXG5PWElkl5pTmNLk-LtsIhDb0mp2MLaqYsxid4gcfDy1k
Message-ID: <CA+EHjTxAH-eW4soxjbSJi8DwbH-yRXE-jJ9s02nEZ7kVXxxWMQ@mail.gmail.com>
Subject: Re: [PATCH v9 14/16] KVM: arm64: PMU: Implement fixed-counters-only emulation
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
X-Migadu-Flow: FLOW_OUT

Hi Akihiko,

On Thu, 30 Jul 2026 at 07:36, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
...
> > Sashiko flagged that this can leave the perf event out of sync with
> > the sysreg, which looks plausible: on a pCPU with no registered pPMU
> > this returns without recreating the event, so a guest event-type
> > change there updates the sysreg but not the event, and after migrating
> > back to a pCPU the original pPMU covers, kvm_pmc_enable_perf_event()
> > re-enables the stale event instead of recreating it.
> >
> > I know you treat the no-pPMU case as out of spec, but the dropped
> > update lands once the vCPU is back on a normal pCPU. Is this intended?
>
> "[PATCH v9 06/16] KVM: arm64: PMU: Recreate events after MDCR_EL2
> changes" calls kvm_pmu_stop_counter() in kvm_vcpu_reload_pmu(), so it
> does not matter whether this function calls kvm_pmu_stop_counter().
>
> The other changes that require recreating the event are currently not
> handled at all as Sashiko complains [1]. I'll fix that as done in
> MDCR_EL2 setters in the next version.
>
> That said, I do not intend to add any extra complexity to provide any
> guarantee for a system with unsupported PMU variation except that the
> user can notice and react to that (i.e., the taint is reported and no
> oops happens due to NULL dereference). The patch message is somewhat
> misleading in this aspect so I'm going to fix that in the next version.

I see, yes, fixing the changelog would help.

Thanks,
/fuad

>
> [1]
> https://sashiko.dev/#/patchset/20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp?part=6
>
> Regards,
> Akihiko Odaki
