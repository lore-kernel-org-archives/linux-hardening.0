Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9113D502
	for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917627; cv=none; b=GNDF7Nii6a+sKX/0dPh/lNt/bIRfcFTQkNxodLq5FPP6eSMyGYNecBLJG20l/kzdOMI6qeP2z3vXHdAjIPWiqw0HUtt1hUKY3ZEGVqUREGEdrXbcPkmLBVK7HvOsJ+4uZOufSuZVxXD9IKrxhofnerIQo1qRfoSGW4dXxk6zu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917627; c=relaxed/simple;
	bh=EjN2FOjlhXfTzPg/EElgB1IbsKczLAtQuB4kZcdGrz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVtriDoAmE9zUG8q4jV//Jjd5cKNC/AdG+Di4kZL5NFK1lM2JzU+6CqV+Jy0S3N7Vqc02XQP93CYyQChHcLx0vdrYPMy/VKhJ0jv4OjXwX1gtRNJNYT3TonpNRQVoFv801XI1+//L4B/EdNjVpthi6ElRQN9UEl1dSQwE4AHTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAZckC15; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAZckC15"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382423e1f7aso653161f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Nov 2024 00:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731917624; x=1732522424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrD3D7iL//Mh4abst76FIfs2+jhPNoFsbOsCfvfo52E=;
        b=rAZckC15T39AAAHjUkHcKvCW/07531piOOnzYnoRefrds1d6WjTE9jFwCGNR4gq0tm
         KcPE4pNuA3/CHTDAyeiPD4/i1cZPChtWY6VV1AHINT8chcQuYBpElBuJrUhdhwrhysnJ
         1X0Ahd5TxXiPJC9sv3x9T8w2b0Un0vyubn/hFOXeRTor4rKqhLrvoCIZkj6vyqwzvoFO
         vI/eCTB8S7/OQBRM1JOsPGBc9R5ShaINHoASg97LhCP0396VOunqBg8uZd46WuDE8qG+
         0QeU3mcVkuSMYxFdBLOyPltEdD7UHjocMaSf8Fc8fygJMObIcZ+EZt5ZtAoSQfUsBiyl
         1Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731917624; x=1732522424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrD3D7iL//Mh4abst76FIfs2+jhPNoFsbOsCfvfo52E=;
        b=T2zTML/jyPze7XejgZbpFA3F4UU16Rrgq45yHjKnlC6HIU06M4XxLHZQi1SrH68YVg
         UtKw5Hvl+MUmKR65aB4b0yFXu9thGyEmIlbO5EkXO1/PfdfrXQ//LHhDU7bXNwgUDwp8
         ZPdCdGJdyQhjh4LTekwHPZhChAyocX7wqOwMMzrwM2dTtSRFvecaasze1Spqh9RuVleF
         FYTPr/BRYuaR0Z0lv21JN+ep6PIFyQrYHhDhT+9wJyOP1Pr+k6t8OjgMzloeTHd6CRPS
         dEckQJtZMsG5jL7w4CD3l0lsW059hDNwpmARy4EDvHDsRNF9SzAxFHw3dliI2an51e7B
         CoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC8WM7OWAqmKUWAat6t32GOxXX0vSsp0yfNBSi79USre3UFQyHTBFho565FsMpeujR70YR0xW2ZJ28NEjvWW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtczU0EjLIiPTtnNs3LcXol85cG9sN6voop0zO6Qcz7S8Zpbi
	dpLbxOnpGin1LtSsrUqCn//qJsYN+u6qj7JziiIMpblltGxwWc4C3YrqSMYfn1+baw5qbUrG3hD
	1eerWrQ==
X-Google-Smtp-Source: AGHT+IGuQUg4zqLcof123OuTET4pS8hUz2MMP7MXmYJJ7qXDFxQQcBUhfeky+bsj5tZDGaDRRwX7bQ==
X-Received: by 2002:a05:6000:402b:b0:382:383e:84e2 with SMTP id ffacd0b85a97d-382383e87e6mr6160452f8f.46.1731917624022;
        Mon, 18 Nov 2024 00:13:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823390c818sm6944834f8f.28.2024.11.18.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:13:43 -0800 (PST)
Date: Mon, 18 Nov 2024 11:13:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <f8ed52f5-51e0-4fe4-a1f9-d840979f52a8@stanley.mountain>
References: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>

On Mon, Nov 18, 2024 at 09:09:28AM +0300, Dan Carpenter wrote:
> On 32bit systems, if you pass a long long to size_add()/mul() the top
> 32 bits are truncated away so the function doesn't work as expected.
> Add a test to prevent this.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Sorry, I thought I had build tested this, but actually I didn't build test it
enough...  Probably the kbuild bot will complain soon.

regards,
dan carpenter

