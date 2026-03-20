Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66683301704;
	Fri, 20 Mar 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019588; cv=none; b=G4VCzC2a9K3hcNGzrw21bPreT0Goqy6MjF31q5u63O5cxTLAdjcUPlWknJI6vvgoFgkIhVLsHBLAZqf825jT5ideMooCbWthTykG98WfbAxld7e0upMGhD4NCvxPrCy1YgyaiUQHyPyo+z+5lKBUL6aS93dq9ejAwF9h2Mvx734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019588; c=relaxed/simple;
	bh=F5NjMNf1IADhR68ibfZoDTBsvxmUxLw8Sk4u+6nNt4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMinI9933v6GipFmyXUCHiAKEDBl1Zhqcgw94qJdQbNwZpRRERe/6Ia502xz4XHIQ2xds7h6to5SLeHUp3B+1ytEGBZJEf8W2+eILV8YCjdy90kCBrVbprok7gVog0mnszVZR8EO2dJ3xHxaCIFQdJh8mJAaqaEJMH8tDzTl3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srZtmN3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srZtmN3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48AEC4CEF7;
	Fri, 20 Mar 2026 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019588;
	bh=F5NjMNf1IADhR68ibfZoDTBsvxmUxLw8Sk4u+6nNt4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srZtmN3Xv/5XPXDsgLNiI+RnCnbvcP0muAY+MLRhpvuaZ3yf04BJvoQBYiZ5tPHW7
	 j/XLgQgrIHVEWaAbyOm7QjhCnEQd4GUi0vLt2k4iW8Bz9LI9fPPC9eWz3mdwUzmptj
	 GSQ6D7tkOn8RfnjGw/lPboGG89iOmQQTk8w7fqy7CrPRD6f+fEAyg0Z04YipHbRl6v
	 /BuAwlkh7Do66OSaz87kJpz+471XYUptlljs9KVikrbzYNPrt59I12vCaX3zpNraBP
	 kMDMkvBcG8xvLv4vru3pll3c6IrT9KcLo+n/UmuzIZsYzzE1VD4g2VxXc4PlKWTcKW
	 x6w2qYErMtVEA==
Date: Fri, 20 Mar 2026 10:13:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <20260320151306.GC699200@bhelgaas>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
 <20260319111315.87624-3-kaihengf@nvidia.com>
 <20260320145254.GB699200@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320145254.GB699200@bhelgaas>

On Fri, Mar 20, 2026 at 09:52:54AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
> > Add support for decoding NVIDIA-specific CPER sections delivered via
> ...

> Wrap commit logs to fit in 75 columns.  When indented by "git log", all of
> these overflow 80 columns by just a few characters.

I'm so sorry, I had accidentally resized my window narrower.  These are all
fine; please ignore this and the similar Kconfig comment.
