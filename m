Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F41917FF;
	Fri, 18 Oct 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295455; cv=none; b=em/U6z9vZnAat0+BGnqK6MDj7ChVS1Cxa2dEAhbx1I3X1QkV3PgCuZxliXtOdUVfZLx5eZO++PxrK5sCZF/i+fUuffaaNXLNg7Af9PIOStFpBSGak84vEG1MrVIFLgpN9YwrfZ5BuP8XD7CdlvDlHUeWGSoovV/QKb1W+3s/cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295455; c=relaxed/simple;
	bh=ft9hCgQsW14cHdeTUVHiNnqMjJ68KAMuvXzxZov2Kjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrdJUxcwqpEJ7lFaCbiMlP7YTYdkps0VU831/NnOg8cdN3jCBzwNieff5OOqA533nfQzV8VmNYrFW2/IBvY2r4nsRmyJ1dn4LdwykXOjeGptWLME1nsiRi4hHKJN1IfdCzYdgmRSsOBAgChdyToaoOHOV+wXiE4W7L9+tLOtqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTtdqR2y; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTtdqR2y"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so1921647a12.0;
        Fri, 18 Oct 2024 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729295452; x=1729900252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQIgcwOpF8GpQsLgj2FtogDbWZde+y8RaY8eMvCGFCQ=;
        b=FTtdqR2yrvc420kLytEjYb45Cv1Kr8Q2n31Ee5g/M1+mxwOEctercgfPJAGKy1bWCJ
         iTXvZ1+JTDOaK9Cuh28ttLP8yiST3qB7IPHrI5LqeI0XZgIrBOz1EL8fkOVDRnKNWd7O
         q9XEbsagoPZ4gIuU/v5sNuJEGK4NFat/RRx+7eO8oPYLngklKtbb0gkPbByD03nvnnNk
         jFyZSn9ez6jq8raqOBAvAFgDooTl01GhBT9HOBxZMYqsm4GRPRhZ85dKeETxWes45t2o
         QmzWNarvblHwhGj+rHtiLr7eK+gR5ysqJJDCdnqKRmoW8kg6hSnuo1NK7JFRBTvoufZq
         y8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729295452; x=1729900252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQIgcwOpF8GpQsLgj2FtogDbWZde+y8RaY8eMvCGFCQ=;
        b=qGOZC11nP5aL7cpmF715bIM4WucnLQgbPKAck80s2UM/RqnEBXzfdaX+UQeJtLVS3V
         DRJW63y7klLaMa081Y/B1E2bVdOldPYv9H7I5J852il6VYoaH2pNEeCxGZCGCtAD9OoY
         4A9OlzB+DJiGhap+3H1vJHwl/rMRJEvGSpULNV4+ciVgCDKoKscTb6lG7ggyS9bJYFBn
         vHyDnNE3HoRJnF7PP1Tg9czB8dgb+rUVWRN3UqwT28HzvEta/TapvDs7iqr/8Uce6fRt
         luO+I7hbdoFONcD+V5eNiqtSEQzUoulfPa++2BBV/+DU2NetuTIz2hB23Kfz0G3w1c2z
         rvag==
X-Forwarded-Encrypted: i=1; AJvYcCW4u6YSoaBWoLXrMROcXI37Qyq6ud9tNa8cw3DduQXxrYEx3thS3ldL1P6hvuHk5vS4cF6wJaVoiUvYrvIMtZ0=@vger.kernel.org, AJvYcCWokWc9fimsYLiZT8v/BxVHiCVSlKC/0peghyQ/kdkBTIrSWXSS80EBG8cPKn1Td+JcQZvuu6kYgKDr2IgZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxldpgu843Wf3Gk3JwtJzg3g/mSkvOskwDWLad7i7ukKb0QBwaK
	QmMa11mxW1RnKcUpur8xvjF6GyYRMC4uJmWeyfaf2J0ghVL91pWO
X-Google-Smtp-Source: AGHT+IFE9JK6B3y21JfHyOThlSgy/691TKbKrXY/mee9sy3R9mQV71UR397nafsW1x5D8JSGyjZQmw==
X-Received: by 2002:a05:6a20:ac43:b0:1d9:9c6:5e7f with SMTP id adf61e73a8af0-1d92c49fa1fmr5518445637.4.1729295452467;
        Fri, 18 Oct 2024 16:50:52 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34b4b78sm2035852b3a.218.2024.10.18.16.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 16:50:52 -0700 (PDT)
Date: Sat, 19 Oct 2024 12:50:43 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen@kernel.org, maddy@linux.ibm.com, arnd@arndb.de,
	chentao@kylinos.cn, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/spufs: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <ZxL0U6bziCxhySUO@mail.google.com>
References: <ZxIcI0QRFGZLCNRl@mail.google.com>
 <20241018153843.GJ29862@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018153843.GJ29862@gate.crashing.org>

On Fri, Oct 18, 2024 at 10:38:43AM -0500, Segher Boessenkool wrote:
> On Fri, Oct 18, 2024 at 09:28:19PM +1300, Paulo Miguel Almeida wrote:
> > The C99 standard specifies that {v}snprintf() returns the length of the
> > data that *would have been* written if there were enough space.
> 
> Not including the trailing zero byte, and it can also return negative if
> there was an encoding error.  Yes.
> 
> Not that this matters at all for your patch, so why mention it?
> 
> 
> Segher

Thanks for taking the time to review this patch.

Is the objection with the change in itself or just the commit message?

If it's the later, I'm happy to tweak it to what you would like see.

I added that bit for context so the motivation behind the preference for
scnprintf is clear, otherwise one would ask me why :)

We are phasing out snprint utilisations in which the result is being
used [1]. One of possible ways this *might* take form is that in near
future snprint will have it return void.

[1] https://github.com/KSPP/linux/issues/105#issuecomment-2421244722

- Paulo A.
