Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0180FC12;
	Sat, 21 Oct 2023 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aXwBQFpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3448C433C8;
	Sat, 21 Oct 2023 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697918392;
	bh=xfkUHsOxxlTRzwO2mYq/zSnnqro/eqkufhUkFk+s28U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXwBQFpXhp/qt1n4kb+0nQmUgiLhuRg+FE7mjybK/3Ct1MQuYFZZjcu5iWBOWW1Bp
	 bJgeZDOf2bjbZLRkeAPm1V5I6X216jcbG66rA5+B5Wm/fz6JbXkvlAQ1faMf4+tlrI
	 KoF6C1mjGvh8Czaqtq8EgT14c3qgRrFwfm3WbMQw=
Date: Sat, 21 Oct 2023 21:59:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0JvRg9C60LAg0J/QsNC90YzQvg==?= <lukapanio@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
Message-ID: <2023102135-work-mutate-a76f@gregkh>
References: <20231021173317.185460-1-lukapanio@gmail.com>
 <20231021173317.185460-2-lukapanio@gmail.com>
 <2023102127-bash-stool-95a8@gregkh>
 <CACi=Ov4gdRwhEAo6Qm5EgQucx-1UZXXMHpA21OUDhNHEmmCJNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACi=Ov4gdRwhEAo6Qm5EgQucx-1UZXXMHpA21OUDhNHEmmCJNA@mail.gmail.com>

On Sat, Oct 21, 2023 at 09:37:16PM +0200, Лука Паньо wrote:
> This is a new version, but there is no change for dt-bindings part.

Then you must document this.

> As for
> "From:" submitting-patches.rst: "Note, the From: tag is optional when the
> From: author is also the person (and
> email) listed in the From: line of the email header."

Your patch had numbers in the name, but not here, so please use what you
have used here in this email, "Лука Паньо" and you should be fine,
right?

thanks,

greg k-h
