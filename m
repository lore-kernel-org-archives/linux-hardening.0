Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9D46AE
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqWM+5MZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCE1C433CA;
	Mon,  9 Oct 2023 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696831937;
	bh=FTNOXpa65H/cSqigLsrU9/tvUHcGMrJuoHxbZJutJa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dqWM+5MZqoUaGuyBCCy0tnTXdOwqal2FpQ2R8vdT92eBmht1UsZX6gnPTT+cyeDJv
	 DrWg5TGEZDgg81bfklvh9WpewY+gPezRmgN7Hhdn9q3/xrqp3yPwyFf1X7+seOCU+J
	 VJNqSNY7hkkSXcXnntiyo2qyh1ym+l6Q5ajXo31TpUuAWGmGVB7ocWSNz+UNh9SHav
	 PmBIMeRrs6PDY3sYngGZ/vgPIDLM6cZCWqx45ngk0Zz9skzbKXk70orlxIyQh8ILH0
	 ah8psLqd258l0ZUzl0smrZieCFHkFfDRiWqvw6ddeF5YGEJAtsG9n3UVb9X23YP6eb
	 22LnrVkmat2Ww==
From: Vinod Koul <vkoul@kernel.org>
To: keescook@chromium.org, gustavoars@kernel.org, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org
In-Reply-To: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
References: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/2] dmaengine: pxa_dma: Remove an erroneous BUG_ON()
 in pxad_free_desc()
Message-Id: <169683193345.43997.16902412199226518649.b4-ty@kernel.org>
Date: Mon, 09 Oct 2023 11:42:13 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 07 Oct 2023 13:13:09 +0200, Christophe JAILLET wrote:
> If pxad_alloc_desc() fails on the first dma_pool_alloc() call, then
> sw_desc->nb_desc is zero.
> In such a case pxad_free_desc() is called and it will BUG_ON().
> 
> Remove this erroneous BUG_ON().
> 
> It is also useless, because if "sw_desc->nb_desc == 0", then, on the first
> iteration of the for loop, i is -1 and the loop will not be executed.
> (both i and sw_desc->nb_desc are 'int')
> 
> [...]

Applied, thanks!

[1/2] dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
      commit: 83c761f568733277ce1f7eb9dc9e890649c29a8c
[2/2] dmaengine: pxa_dma: Annotate struct pxad_desc_sw with __counted_by
      commit: 0481291f0ccbc5147635cf0eb108f9fe5a05ee7d

Best regards,
-- 
~Vinod


