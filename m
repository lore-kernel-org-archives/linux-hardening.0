Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C43D0BE1
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794785; cv=none; b=e7c/ZdQDF1n46j1RIsSrRnBddPyvW1EYfOOmNfXEfeHnC4qiSmcd67/iIuybHoESu6PdJ9StwEL0fSetkU1IR+UeN3e92UQoOuI3s+xpTzC2J9DM5WU36iP3+7gfrXWTLNT0Yw33de0EgAetLfgcAbs46zp5jc0JU5VXCbeVRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794785; c=relaxed/simple;
	bh=ohY7bb0kh92g6C2NfTVSoNXg0kcZoVBjk9evkK2s9rM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeBMcw1TKaP0fRxh84BpMZtNyG1F2tslYok0PDeG6fbhMmMIUG6OtE6nBxYPcnUnjJ9tLSellw2vn9JTLoTYTySLi6ByZa7zBkhW0wJ0kVj/oY2VWxhQjv3o8bhE8guy0PXJ9Eg5y1q2JiPL7j7h6k+mK+4pIzqkwULofwOnlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PddyXCmo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PddyXCmo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eeea039ebso624054f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781794782; x=1782399582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FzucqwHZo+slbYBGADmmQASUp/rGJyNeP3ZJNzy0TE=;
        b=PddyXCmoQJl4pSuQtFkLYEzvzTRZINzoHemNylX5881RPJCuuzSFJyLtWBMUhzPfeu
         kN+LQ828xTnMgMrm0xLF27FNLYGYKNv1shpS3Q2MPHo5rBAWp9v97t4dg8Z6SSZB9C4X
         LS7nCpgMCdYa0/PuTFKB0ssfSVSM/GFGk+Q07hNADoDeelRWXqcdfJiPxMhkzgNnHlm3
         I4L+mAK+NV49dTHSyeYng3c2Vf8bQ3FoirbstJqqmF1y2KDd34XPzx0vuLUUz3C17xiE
         lcwMxynaqaYMtLjaljwBuBApfMgxBHE6WpaPkOCc/zNBPyWLmz8VjY1DA8X43FpnODVF
         Eu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781794782; x=1782399582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FzucqwHZo+slbYBGADmmQASUp/rGJyNeP3ZJNzy0TE=;
        b=L5LemLlR0dtep+ftcaLO/bXEp/qaDIYdBnCsWTekqBUlNvJ1PSqWuy8eZXyYWfXdTp
         /djiJ/c7Ym/hKWgQ30Z9KNXoBqtNn6FE3vJ/GmS+dSUfoul7owLRuKP7jehUJC1IbykF
         tHNS+n1vPYSHT3S2IEbK8K9QW+ygJz/aqEiicvu0poPSqBrIHXTlud7Sc0fBgkTqKbyK
         x8vxICuqCkOc98MWWIJL1NQLr+ff46v0MIC49QZ05ctmEsg72qT/pBWaGq3Ep4iMG3YI
         f8Md+TVe9xxroxnjuJFmVhzM0WyQKaH5QHVowIRkdFOqWRQam7ZhyUgROiSJlxX7Qz3k
         V+VQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YtbiYEI8+D2bnEAuPzeKHbqjFJY5ZWv/FwXhfh78F93jzN7fvykl3NrrN+C0WHj/2U0/eP/89Q2ykB9kVzuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXAayEwhFDBbxkQx4y8xkvZMdHmjMh4kX0dc2ZXnyEacSbi/X
	rPegJbeWhhh9wQgJPav6QC6h1+FNxb6NViQoNy+iTaixADZHYJ7e+CMa
X-Gm-Gg: AfdE7cmSMjU0GwN6jTLIej0uU+b0bqljyLCbU5zZEBxSIlss1M+aOzYUAkZXkwiTlrB
	c3TlN/GaYWc8R4WfEA6sowticUUwfVaWs97z87andieU1Ep/GnZl6Oxe/Z+GnZ8YPojGjTcl+ps
	272tQPtdFbbpTVl3L3/EUujJDRUFLBdpKRB7024Kzu8MrnYWzUrx1uOd6LtRitku5j8T+RlJnrl
	mrRgVv+bHnihifF+arWlHzpY/yKYW2UpU3aySmkI91H7nfWMvsWAYay6WIxBuC7GZp+EtR1H8Ds
	BWSH9uRKYxbwPGBXh8mgPLoFv3fYIsuPxh9bmpBAWJRY7xOy0HStF33LKjN7HcbgX8Wbdll/LcV
	9nLgBpJaQ8n1sue3K+Fa4BP6pJ+4w0sUjvhMevO/r6XGKvCkgiX/D3kHc0bSdQsnT4ybupWqf6j
	lW52X2xvcmS1VCmPVgtpp5vMMlOEga9BZSiNGESaoDKsWPyc3jxA==
X-Received: by 2002:a05:6000:240f:b0:45f:f142:d56f with SMTP id ffacd0b85a97d-463ab7f925bmr6881625f8f.12.1781794781864;
        Thu, 18 Jun 2026 07:59:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b1083e3sm20845830f8f.20.2026.06.18.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:59:41 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:59:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>
Subject: Re: [PATCH next] drivers/rpmsg: Fix copy of channel->name into open
 request
Message-ID: <20260618155939.6cdbdbac@pumpkin>
In-Reply-To: <79c1dda2-153e-4b7a-ad18-c72db1cf4a00@oss.qualcomm.com>
References: <20260608095523.2606-33-david.laight.linux@gmail.com>
	<79c1dda2-153e-4b7a-ad18-c72db1cf4a00@oss.qualcomm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 15:24:17 +0200
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:

> On 6/8/26 11:55 AM, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Nothing obvious ensures that the name is less than GLINK_CMD_OPEN (32)  
> 						     ^ GLINK_NAME_SIZE

I was writing a lot of commit messages, most with -m 'text'.

> [...]
> 
> > @@ -481,8 +481,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
> >  				    struct glink_channel *channel)
> >  {
> >  	DEFINE_RAW_FLEX(struct glink_msg, req, data, GLINK_NAME_SIZE);
> > -	int name_len = strlen(channel->name) + 1;
> > -	int req_len = ALIGN(sizeof(*req) + name_len, 8);
> > +	int name_len, req_len;
> >  	int ret;
> >  	unsigned long flags;
> >  
> > @@ -498,14 +497,20 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
> >  
> >  	channel->lcid = ret;
> >  
> > +	name_len = strscpy_pad(req->data, channel->name, GLINK_NAME_SIZE);
> > +	if (name_len < 0)
> > +		name_len = GLINK_NAME_SIZE;
> > +	else
> > +		name_len++;  
> 
> Should we perhaps do something along the lines of:
> 
> WARN_ON(strlen(name) > GLINK_NAME_SIZE)
> 
> to prevent silent clipping?

strscpy() tells you whether the copy got truncated.
No point calling strlen() again.
But I'm not really sure it is worth it.
Any length check of user-supplied names should be much earlier,
this is just ensuring this code doesn't overwrite its own stack.
(and ensuring stale stack doesn't get sent as padding).

	David

> 
> Konrad

