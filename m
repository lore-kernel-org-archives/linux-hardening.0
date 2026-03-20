Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9933DE43C;
	Fri, 20 Mar 2026 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030533; cv=none; b=WpsBhoLFgJdF623SudWsPHo8CMYl6S3Mvi6RPd7AThQIk7pLpn1tvOjwUcwTJSqtQr1bpYvATFwr9ZzV6Kji6V4e1UsJk9T4YJRQA55P583/tpPmO7Xf5pTej/VPkpHUNfCWKHEp+evREJUAl1gGdEka8S5CAcaAIqdlTMunEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030533; c=relaxed/simple;
	bh=9kPe7L8w8yNoC/3rVWXw1UQUGy4KdxDRZFpsLFau+28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx2mL7BwicH6PmdYKXiYzIjMQECvSBxclrouzwM6Pu5P9UeZxQkZNJZ5/CCm7U7XxjY0aZr4+i01UEyxidCqFssc2GTpwBs3cu9Ry8K9Phv5m/XXqSmsb598fsYAxE6KuGcoI7WupYy88iOFGHqIVMJ/3Zii3kpgp21aO1RN6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvyWdItK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvyWdItK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D3C4CEF7;
	Fri, 20 Mar 2026 18:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030532;
	bh=9kPe7L8w8yNoC/3rVWXw1UQUGy4KdxDRZFpsLFau+28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvyWdItKAFGkXtbpu9IZCQfa3UQE3LpEHeKH7IpwLR69wZubEGnT4GPR/p8XJU5kI
	 YAtY+08BA6aAhwa6KUbgCA4ipo6n14fVc9YBpNL+yhnWhDxou+UGjBuFbFy8O4Ksi0
	 ZTG/mQ+ftMFrfE6M/XBAJhkWGj38pFy2+fTzjOmJdKTzScwQ7WhHluJkNjpFK9+5H8
	 3sfjl2QDIxhr8FJMzAd7IUUiiCSspiV/PjmsM3GEnIJesh+Ct0vVEufv1mn6f9zqV3
	 abKIm26LU3KRD0E8J4hZO9wMXAKcPAOE/S9dVkT9I3KmMkWM+mSuHKZaizLRlatgoA
	 Dlg9kjrerghcA==
Date: Fri, 20 Mar 2026 11:15:32 -0700
From: Kees Cook <kees@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-hardening@vger.kernel.org,
	gustavoars@kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
Message-ID: <202603201114.9A02FDA977@keescook>
References: <20260306044536.149204-1-rosenp@gmail.com>
 <20260319220901.GD950375@killaraus.ideasonboard.com>
 <CAKxU2N856yYXURRf3td-_RCpe9hyX=zAy3qtD3ki23RjgO+a4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N856yYXURRf3td-_RCpe9hyX=zAy3qtD3ki23RjgO+a4Q@mail.gmail.com>

On Thu, Mar 19, 2026 at 05:11:22PM -0700, Rosen Penev wrote:
> Technically kzalloc_flex is simpler but I assume a devm version of
> that will be handled in another treewide commit.

Yup, that's coming. I wanted to get the "first pass" of the base kmalloc
family converted first. There are a few classes of "kmalloc wrappers"
like devm_* that I'm hoping to convert to type-based allocations. devm
is next. :)

-- 
Kees Cook
