Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEB47F2CE
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246143; cv=pass; b=Y8NrUs62HEltR90/i2lsL1ckIyKJ0xm0oiP6PLsDlzFWyNKQaXqruGUQLc+4LXUG9UVy0YiGIOLLz9orfEIJEMXrFUepuH+QZoQKarb9hBDzA61Fill/cx3c8VtHkgRxZLB95jVDoCYb/0URW5KpG/HgJ51DdvFxLun44pupWg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246143; c=relaxed/simple;
	bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J65Wyu5Z7/RCvBJ/8kTSHAOpLnxlZbpUs9DznGRcdPFshEgWNbq3mq9mPf6cTxidf2ABDUu19sTBzrcugu+PWBNDPx9V2YBXXiEiRiwFJLuv+qy5INfbGPcdMSyyS3vakxbMJRxFNKjntznVfYfINceqj+KUJ61qLBmiPhmH2zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhlFp3TR; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhlFp3TR"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b01cb18515so64896e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787246139; cv=none;
        d=google.com; s=arc-20260327;
        b=S4OElGf2rm+5iuBScQCQbJM15GvR1aLdv0JvNEa8qy1lBWWhDfQ0ya5blq+LyaZhqh
         ApDjMzdzPQC7w9tVgvFIjVzkHF8Flw0acvH0Yt9l32osDh1k0CZAzx+KsSinVPIN7PBC
         7QITIeZGzZ6GHLe2RxB7q2sEEOWvDLuGGK5Iwd5NKqhaHQiVKvFfLIRJVR/rBPcVB1t1
         hl290R5nAus/aV3w11tiAghbq1aEy6wsye+5ppU4sw4t5AEo7N9btORXExRgaZtA4BKF
         PG1HzYsXiJtBPvI/AA6nQ44bEbjkLUq5vuEq6D+62PSM+vwqIe03QjweSWp/Jdb5toe+
         BHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        fh=5lzHLoYgn7gR3y3f6fvP7JZem/5i7gincyER5IPrD1Q=;
        b=fwLR7PwsZs3NNKCDOIc83J7sIXfEH0TJE8znkjgCgpUoHJaGARTPQFEoFa1GD5yNvb
         uKADzm2fdCApVZxf5GtVb/D/z/x+aET/ugzdPllgx0YdQNGKGEJQWj9z4hb4R04k7Kro
         l47hG7FoFtvu5nwBdcLiB3EQMGiksOB1AS3YvNH2UsrtRtjYthL+9fioShvO5I2z/tHZ
         wUHwXYK8w9mW+z2zvV4D6T0hZhZg0bR0MDb6/ME/fccpHQ6ijdyx9x0Gie8jaO/d+NcF
         /EoXeHdOuSsQls29qkbTNhMOr2gL39qJJDC2LqiH1oQvX9ebDXVvw1MCMtOqdw2gFOC5
         3WDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246139; x=1787850939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        b=QhlFp3TRefwrLZ5PfMTwM44EhPA7eyKSTgpKlbnn8CsBNAd+6s3hZS463nASuDpHC+
         AJxWvHeeK6gWkaANJOs1Li8zVYb/fJ8LAPNBJW6zoGBncjp3YZXPBeXJl02D4JiR/9hO
         ycHMAUkbsmDiOuee7uP63wrTV/iaI3TE1pEV6msMexdgEaU4uA9feVoFm8Z1cHGdsp1y
         wZNhRoJLmizaB/068ODHC4Udt1Ai20xGeK0V3yREl9YlobBc5n9g5JWd29Zgycu8I7sl
         6CBZuH9NWPt0QyEeG7aaAkiBQHc5bLdWkGYoE5bpXonU9GlrhZaAT8kRnfM5/ZCCmH2r
         xCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246139; x=1787850939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3c721Up4XKT9nSGpOXXtxDHVpHlRP7Uy92JTc+lNdns=;
        b=cbvt7FcFjzxIb91RIjg3G2A7na7vQJJJwpDlt3Tl7llaoQz2RAT0Zv9iotUPxVVGpV
         1czYyLcjydKufejF/x2UiUsr3sYGG/kclFl9DTkvEAaVnqODfkt6XqdpCcUiONSWVN9a
         V0lmtBPzKzvQt3nCbsUE2U0w/b3kaTk+j4b/iujhaVYgB8aFnhXuzM+bvz5RApX4Qqc/
         FcWX9DgvoA3AbfGe0RPI0ZNbE2YtuI0GD7i0fhRukpPxJ+cUc0m/GPndgZPtpZ0yfoIX
         Pz1b3DPCMCwOnZ8ku1vZSAfiBefTMdpjndH3EGPPtsBiSAFVDm3ceMDt0BlJNOtue8+A
         zkUg==
X-Forwarded-Encrypted: i=1; AHgh+RojzJ4FAIfYRzyhms1YXtve+w5AhbnfBapj5wMn8EBYJt9xuxhlvgY62bAqXr/or8RfIBPr7xWRIQo3QlKmEtY=@vger.kernel.org
X-Gm-Message-State: AFuF++m6wveh/rdY+M15p+a29QFutZ5in6kUWd4gGwBW35/JU4QvVpdA
	gj+2rqbJ8vIqd7DoX0uj/yHkwTZml6B/BEzUjPu5rqJCFUBf6fskolpnn3nUzEgyx+9NO8RfUjf
	c/nicQt2ur+PpqQPgpyNvOo1M0QNtU9M=
X-Gm-Gg: AR+sD1179EtF1gltkI+9S/zZIcHUjuIxgBSCPOmx+xlwyQlyz6Zo2FkdZhqUpWJ59iK
	hTutu6fTEz36LY6fGh+jirTIWBB2ZrMeDtbkgy0E3e89+RVFlRdmHnFkG4DZHNk9SYLMwzYgr/S
	sfNW8W47JlD6DwP8Qm+oDhx/bxRgZngPZdsHfj+xa0vxYMvPYL1+dQCbSDJ5YR0ESBvsw3upMgS
	sTWNh0DM8NbqWeKwmJMFenltjf/eqYqH1RS4lxXK71cI6fj01nsHUORxvTTG1yUt8j1cTUUvVpH
	YPohqQxD8erF0ETI1+Lont+QsYJq+6EGoLL9HQr3An+poSms5qfE0IAyWYF3pRPHl4dbDCl3YN7
	cMtzpxoKHDv5qs4B2mcW9PwmuiA==
X-Received: by 2002:a05:6512:3c92:b0:5b0:bc3:dc11 with SMTP id
 2adb3069b0e04-5b478d1f07fmr4752522e87.22.1787246139023; Thu, 20 Aug 2026
 10:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <20260818095654.5357db1d@kernel.org>
 <CAOQiBWM57ZBafMcj9MaegHBuM21313O5PqAAGXdHfvmHxHp48g@mail.gmail.com> <20260820100302.1609c979@kernel.org>
In-Reply-To: <20260820100302.1609c979@kernel.org>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Thu, 20 Aug 2026 10:15:26 -0700
X-Gm-Features: AcwNN1VG-G40EWmCjL4DcV3v9ciEADsSL9chtIKAvcClckRaycXWK-AFTAquNos
Message-ID: <CAOQiBWPZg4xkZFsUm9g6XBYz+vixaKPaofdv1rvxGwufD3jm9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] ptp: ocp: Add R4006 and V9 I2C peripheral support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I will split the series and send the IS32FL3207 binding
and driver through the LED tree, and the I2C mux changes through the
I2C tree. Once those prerequisites land, I will rebase and resend only
the ptp_ocp board-profile changes to net-next.

Thanks for the clarification.



On Thu, Aug 20, 2026 at 10:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 18 Aug 2026 11:12:35 -0700 Ahmad Byagowi wrote:
> > I should have stated this existing hardware and end-user use case
> > explicitly in the cover letter. I will add it to the next revision.
>
> You need to send the leds and i2c patches to relevant trees first.
> We won't take them via net-next.



--
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
