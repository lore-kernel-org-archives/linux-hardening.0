Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E643B42F2;
	Thu, 17 Sep 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635504; cv=none; b=M2Fc/uMVyN4NWj3T0F60rg6b0HJq6HkI06wolqDOCbIftZVJisR0zN9H7tUODieEphnF67sIjW4gwxjXJUZQtZecBxi1AGEeT6ejB+W+YN17WTOMQB8S735A+IWV4yXOvuRK2D65C30lATEjMo7Qm+k9ZkLwSkpZY+rzgE3C8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635504; c=relaxed/simple;
	bh=mTF0XmkyDNDSQhyoh8UpmLj/c9wslJHPo4+Rx1XqAyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frXwtE2k4Wvx/ntmQmnlX008YLPM5uUoNfoSmPRX3aIY0Wtj7NkiHGs+vC43Uh9Lsaa8074n2RwZL6T3lZdpYFM3sSTGfObtLUptKperfI1nX1OaN+P5ha67R9xCUpfaKBVgtjHr0dUtBOwK8Nk+RWduTXEpEjFWK8iMHeJQX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: andriy.shevchenko@intel.com
X-PTX-Original-Recipient: kees@kernel.org
X-PTX-Original-Recipient: andy@kernel.org
X-PTX-Original-Recipient: akpm@linux-foundation.org
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 75364202591;
	Thu, 17 Sep 2026 10:58:19 +0200 (CEST)
Message-ID: <1c25083e-3f0a-4ae2-85d3-9e570a2837e3@pengutronix.de>
Date: Thu, 17 Sep 2026 10:58:19 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] lib/tests: string_helpers: drop unused parameters
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-2-7f8bd986fa33@pengutronix.de>
 <aquUT9FgY_Ep_4E4@ashevche-desk.local>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aquUT9FgY_Ep_4E4@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-17 09:18, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 07:38:07PM +0200, Jonas Rebmann wrote:
>> Drop the unused parameters from test_string_check_buf() to improve
>> readability.
> 
> We need to find a way how to use them in the error messages. This is a
> regression in fb57550fcbd8 ("string: Convert helpers selftest to KUnit")
> that drops them.

In that case I suppose I drop this patch in v2.

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

