Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302091DD863;
	Fri,  4 Oct 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067576; cv=none; b=YImM9rGM0vbnQBgI7qBKhBwg0XPYolxBflseYAmBxsRZjLuNpGY2n9tRWRfSwS6sSscXYjjAvmd7xwyee465OTnJafHDYdSMJ/g/vDI5j23IagljzGj/Jhh81QNxKvB+SZFkfIoxnXdtvfbA/uAn2pArvju4bGKMZjcJVCs1d64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067576; c=relaxed/simple;
	bh=k9q3R0pxsWmTTbakmAC1U3EJ9dFWovW9rJrwDCsmEpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e14voWQ/KSlQYHRdsIeSiqe3KA8yUB1YOdnLPBQs5zkd5mm4UpUmhbZq+vf0eiPbijIJR2MuRwQr4hvR4mY7EuEDw3lD2iJEmCbS5WbPQih4iGQuwx6tpo9OW3WLCiHyGUYT4czjV8yx+id8jWIz8WU0VElQmUVn3FMVMqm7ff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6NQLArO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6NQLArO"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so1822564a91.0;
        Fri, 04 Oct 2024 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728067574; x=1728672374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IrTg0kaopkLeKlPu7sTXTEx4d7ujCV3P+a2ZN/l+SlA=;
        b=g6NQLArO8P2b7Te1b8RgmMhIRMeUPRnvQGUT3yFG/QwNMrlQDWKS9O3K11IlM+wiMi
         ZgUy5w1HFgF8aBwvPKshRpRPquQMAWh4XXg7gsjdAHuOny/RsIhdqOTglcS87HKlWa9p
         bsuQRdbn+4ROMKHH5k/3AhhSpI6VmzSIxz6RaRbxiu19sfMIpkh4wIFETPqev7xxcC94
         ZSWKAmPbVvAc/sMK5WCbDCLQ5QjpdPLYGaSI6GItjJ7dx5kcc0E3wvJOy1uq/KNywK24
         v29L2DXG4KF0SDUQ6KpiDwUK/qH9nk+73Z5UBv8laTjgOsoUFQ6TEiY3GnTRmV5fESgt
         DFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067574; x=1728672374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrTg0kaopkLeKlPu7sTXTEx4d7ujCV3P+a2ZN/l+SlA=;
        b=fNODX08sZJKKuY5+qmZNQnNjKf3cJKbFjcoeUd+7/YvIk6m4cYHgybcGHdZSaSz/IC
         E/1GE62r37nZ6AE3A8WNNpCyrRNRSZthe2d/+8kYbCHuff6xD9jnMtqiUkLjpbk2IqNS
         CuE2NnWJJij+DfiYQ4C7JLsijjTmcci3cLKo5hD657x2gSIKIJ7+vqQwYg08kRfMSaXh
         RUcVQlCMLR5ZGa0j3GVawlSdrZ4N+2jd+HYgNgOX/F3n3MlTKe4VCIuJxOh2pddypO2k
         2Yq9RuVjeDsvk8uhgLsDaODhOzIiJKCGnyXtc4q0T1/hd+KVOo6UdyaW2rjed3yFGmzi
         LYHA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsq4Mt3VRhANuf1GNOYlPKXxXWsGy2IINMpP45bU1MlAUYRTgJJlHy4/rGeHe9v6z9Obc8bYblJk1h5xG@vger.kernel.org, AJvYcCVyLFGcBOKj4hHItkCrIhUSpUnMTIhXshzdbuVwSnpVyHedsUX97MV9tapCQ98biN7CBAM+evBlNXotfNO/jE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+KrMqRrnDEtjsLEWLQam4wtvTReJ5N/flPPMLVF8qF5pZQGG
	Zj/4fl5JyoRsbcKVlis8OMtYQobiIDZn/9rUXyiP8JuA5t8fhQuM
X-Google-Smtp-Source: AGHT+IHVr5A5Oa1U5sfqmIduA2f6Mb43CYYv1LjnCC6EfjKhOV38SAV9u4aOc+k7yBHEeaIqQFUr4Q==
X-Received: by 2002:a17:90b:80e:b0:2c9:5c67:dd9e with SMTP id 98e67ed59e1d1-2e1e626dc29mr4752757a91.19.1728067574318;
        Fri, 04 Oct 2024 11:46:14 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca28fsm2007631a91.7.2024.10.04.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 11:46:13 -0700 (PDT)
Date: Sat, 5 Oct 2024 07:46:08 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [next] ARM: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <ZwA38C2qBDYkm7ce@mail.google.com>
References: <Zv9aEoDo1k36Hg3H@mail.google.com>
 <Zv-w3rXt1OLnAbX6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv-w3rXt1OLnAbX6@shell.armlinux.org.uk>

On Fri, Oct 04, 2024 at 10:09:50AM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 04, 2024 at 03:59:30PM +1300, Paulo Miguel Almeida wrote:
> > There is a general misunderstanding amongst engineers that {v}snprintf()
> > returns the length of the data *actually* encoded into the destination
> > array.  However, as per the C99 standard {v}snprintf() really returns
> > the length of the data that *would have been* written if there were
> > enough space for it.  This misunderstanding has led to buffer-overruns
> > in the past.  It's generally considered safer to use the {v}scnprintf()
> > variants in their place (or even sprintf() in simple cases).
> 
> So, basically, it's unsafe to use the result of (v)snprintf(). So why
> do we need to change locations that do not use the result?
> 
> This patch is mere noise. Sorry, I won't be applying it.
> 
Thanks for taking the time to review this patch.

My take on this is that it boils down to nipping it in the bud proactively,
so if the result starts being used, no one has to remember to change from
scprint() to scnprint(), which can be easy to miss.

There have been other instances where the result wasn't being used, yet the
patch was still accepted [1] — should that help sway your opinion. :)

I understand that each maintainer has different approaches to what they deem
trivial patches, but I hope you reconsider accepting this one. That said, 
if there is no utilization of snprint(), we could eventually deprecate or
remove the function altogether.

[1] https://lore.kernel.org/lkml/20231213164246.1021885-11-lee@kernel.org/

Paulo A.

