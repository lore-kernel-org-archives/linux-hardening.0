Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269A13A894;
	Mon, 24 Jun 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237299; cv=none; b=GFewhPIWLDWTLjqJMF+KfcxxyMOESaye4GfKqs7ieONKw7V7f7/7AgYamS3MJV+dHpjYrZw6BeoOaaa/VfUqYsVFDHn2SvPt9cPZKfSrmFyBxanB5MfvmHgDSNWIO6ywns+3DDXTwXnnL05DYxpuC25DT0z/eBRDRIJYhBtlixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237299; c=relaxed/simple;
	bh=cbTvhZvij46fKlqp+WkS5Lgc1O3Pj/t6oQXMiZIZRBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtPBpDPKqjkCnHUMeqd1zGHNw9tP2dLGaNvyFp8iroMIbNTKBC+2idHx7bcOROluL9/2dT+mDHx83ojdyNaBuQWLLLuuTkMm5ZpMUAWisi589xFurHNCT8Oejgp+CNFzxu55wdoVymx2vLCrzgwd3DfyBm/aPInW+HJA6LLXySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crxC/vOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crxC/vOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19F8C2BBFC;
	Mon, 24 Jun 2024 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719237299;
	bh=cbTvhZvij46fKlqp+WkS5Lgc1O3Pj/t6oQXMiZIZRBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crxC/vOoq3oJHPn0rBccw/H7NNkrN71VIpYlIAy7Aba0DWlB/TKpyZGPwsMZHlh4c
	 Hi+kSMgp3xHhYLRt+pARsD4QpdLYgEA2ZCZVUADMCEVZlmV72T7NXW9ZLF1IKUyDgs
	 V7GZtfyM/d+w9J+LuLppoLmIzBMoxK04Mu2tm9TR+CsgF0ugYXLkQqOYyIyTIoH53O
	 UmqueTYcxFoCi7R9SeK2aX4Uv2awmELTBtBd/TlSvnOn7/RzKxjUmRlx76E40ZuIgQ
	 ZyzxtXZGgkiDyzqJImCAFscrtPGzGniYZKmEM7gILNcKq6Duqdl+hQKubku+mnMUXg
	 Kp6WRJH87eoLg==
Date: Mon, 24 Jun 2024 14:54:52 +0100
From: Will Deacon <will@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240624135452.GB8616@willie-the-truck>
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=V_TGvRgZy9uFzF_tGX25oYzVrjHRrg-CphwmhmJRwsKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V_TGvRgZy9uFzF_tGX25oYzVrjHRrg-CphwmhmJRwsKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, May 17, 2024 at 01:01:58PM -0700, Doug Anderson wrote:
> On Thu, Dec 7, 2023 at 5:03 PM Douglas Anderson <dianders@chromium.org> wrote:
> >         local_irq_disable();
> 
> The above local_irq_disable() is not new for my patch but it seems
> wonky for two reasons:
> 
> 1. It feels like it should have been the first thing in the function.
> 
> 2. It feels like it should be local_daif_mask() instead.

Is that to ensure we don't take a pNMI? I think that makes sense, but
let's please add a comment to say why local_irq_disable() is not
sufficient.

Will
