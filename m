Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0818BB97;
	Fri, 23 Aug 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432553; cv=none; b=uUqEOkQlalENipqC1TIhYw/9Ev8BjVyVHCkggWNLS2B4kUsMHY03JlEh4Z6hIaxDywVtGiEMqYHsPsjcEdfnomFgHnEwOhq0Pc2XThRijSbY6b68fHjBZW2hF5cUx/MoEB8+YfYlOg1CU9Ksp/9kd0mj2uVjfOwHddnK5MxNAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432553; c=relaxed/simple;
	bh=PAwsiU4bIYX3E0qYsbmM9AuaSPSKSbzpsu5/n9Ejdz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOesmWwXZ0/JTg9clASQ2Mp5GUB2czfdXf17HhR7YscTKR8Loiz2wj/R2PEGk6dRpFTyFnZyDMfvoHZ561MQwgFjeb3FevqjSE/be2jY8qtgj5swnf8nlFgP+lpfW0UaQu+RBEhL3+VEAcrZtnDFhCOjsqC43J8JgmtMp718VoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAuvaj4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAuvaj4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F8C4AF0B;
	Fri, 23 Aug 2024 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432551;
	bh=PAwsiU4bIYX3E0qYsbmM9AuaSPSKSbzpsu5/n9Ejdz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAuvaj4O5YFi+PNVvflM3EUNpqLg9HPhJ2aCnLCVZi+UkyK3bgCaeSAgzU1Gi4Ar4
	 8UZGRsb1+gvmvM2qjy9jYd8/UWg+u7VWqSbBr+eoqDw9DvnbbmgPfHXKakktuD1Lgr
	 tIgc+rdSB/62ycS19erazueEwi2xS2tCll8oAPeWrAqMU2hLcnxdmZX8pw2xy+isYZ
	 zELLrbprZ/tqr9Xc2U2mpKlstKnYX/iWwt5mz1wP32lkwqLaKlJBahPd1LPzR52di6
	 TRbsCB9eKmGjUCGUWNoE7XIwGKHXVbyGUlttSh9g8O6ZEOeiA1uuWKcMAL80qcItOm
	 JCC41QF5DCKNQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Douglas Anderson <dianders@chromium.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Marc Zyngier <maz@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kees Cook <kees@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: smp: smp_send_stop() and crash_smp_send_stop() should try non-NMI first
Date: Fri, 23 Aug 2024 18:02:10 +0100
Message-Id: <172441009653.1922898.7572192517928205189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
References: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 Aug 2024 14:53:57 -0700, Douglas Anderson wrote:
> When testing hard lockup handling on my sc7180-trogdor-lazor device
> with pseudo-NMI enabled, with serial console enabled and with kgdb
> disabled, I found that the stack crawls printed to the serial console
> ended up as a jumbled mess. After rebooting, the pstore-based console
> looked fine though. Also, enabling kgdb to trap the panic made the
> console look fine and avoided the mess.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: smp: smp_send_stop() and crash_smp_send_stop() should try non-NMI first
      https://git.kernel.org/arm64/c/fdfa588124b6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
