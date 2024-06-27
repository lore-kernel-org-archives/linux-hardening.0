Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43ED819;
	Thu, 27 Jun 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478304; cv=none; b=cZ4FjmzEVHiA2jCPFs60qwp6CvQVOKeaQUz2lJrD/JEu1ao7lkslB2nAutJthEr7luejGq9L8EDIocjg+U5C8XVoFPWnTEUStwEqu8wHJdLaX2VdaFd+QkxLbWc17gg/1wYIO6jRRtahAwagA1PD7w2Xj7MsnZ+SAKOVaosCUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478304; c=relaxed/simple;
	bh=hubQRi3K33e2WsdIY6YVbkhZEtyAAG1vob1/ZwRO5Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0qNzvTbRvGefqjbcabbRg1FDg0ouw5tBZXqRBNVQ1RnnNs2JA8sfA1X9tj7SfJ7hHp6SHPsDjEnsNbSRdpACscguykVJRQ0EwJvUuWxPZCbO6+HKI5FkzUhhvZDM2wTxvpxY07zTI1RweiD5dgtUIjxKKfHTIRPsUCdJYbmUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7WlzIV+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7WlzIV+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6fdd947967so584857666b.2;
        Thu, 27 Jun 2024 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719478301; x=1720083101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55f7taZjbBJJ3MgJBAC7VKX0XUoAwlO2H/Jhcuun0FE=;
        b=c7WlzIV+cYiXAUDo9U2/i3rQm3ZQoAJaO06+ZSSFFicjW6HI3rndCz9sinbfm9A90p
         MfDG5g39852TMzfp9bu1H81C6XMjvjchF+hBtgf4ut1Jd8RpfuweK4hvkSrt1PHX/joz
         acSU9bOGWIruY+LXTFvX1/JE3Ns8GAhTJxQx0UklbJUNazPeFDqI0b6gtex6t5T9cRLz
         Q2jr/J3VhGA1+Cunj8BrVbDW7y5uEqksfiod6gl6BT0T+SoJek+3iwSETvMZ/0Vw7uNN
         tCC37UsRtot3ewmsWiIogtLD94eiZyHOXVFXpWL0ncVo/y8jIlaGjoAGyIgjIY2E2qcZ
         4gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478301; x=1720083101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55f7taZjbBJJ3MgJBAC7VKX0XUoAwlO2H/Jhcuun0FE=;
        b=G2UqQhUcylIvOKaqVgArcieweJQc5hqmraIshn4K1GHm+l+BVCHFHF8qsbLF62sARf
         JOSBYgUD4aRLhvkfB2dWgbmtiJm44ZrrR4hhhsBb5HFrWWNt+ItX44WQhnmqNVy6/cTq
         NqCKLJiZgScmHGWj2N5c0Ftz/hn2rAAcTE+ewSRXJniGTg4ZB4YpOr3pOi7NsUQLYKHR
         Cq/Nk8v59j7yjOK5SMXVkped8nps6BjFWqCW3fUbDxhB30eizsMH3i5sLmSMPuamuHbc
         YGPKgRtosg7jUEKWu/T5XebTnuc0bbRDGzD2jyBJEFPdaI6aVtzgm97LwZ2JwToA/6ta
         v36A==
X-Forwarded-Encrypted: i=1; AJvYcCU1SpsbHfsKNHLL1Z3oohgK/m9WfwOrVnegUqdiUEYTO5snweDYs1bZauALOSzGuWQ7kZ33R7imxTcDaQpMrMLyqFO+AwNywivF2IEVOv67VxjGxAOCZOzF8R7DfPibn4s0B5a+0M2CvCF7b4TQ
X-Gm-Message-State: AOJu0YwWvjo9+kqO6zt0VkxWA4TlaH4T8lZNglP4KFvkbjWQYCO7VCXA
	MtJ3QVjFIfPYXRG1Yn+iCubMU3dhA7EwyADJOnireeh6puc8cn2uOgPGnGrzE0mRw/05MpVS/cA
	cvaAM4KQDO9dUKRG6igP6VaFWiN0=
X-Google-Smtp-Source: AGHT+IEysqzmVVLw+HFmUUz2scNUo6iQxYc3/241G9X2dPYLyY+TBadjBw499oKmWuzziHRPm7lPQPAi9dHjLNNbQ1A=
X-Received: by 2002:a17:907:d386:b0:a72:8d4f:6720 with SMTP id
 a640c23a62f3a-a728d4f6df3mr312606766b.69.1719478300823; Thu, 27 Jun 2024
 01:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502154823.67235-1-linux@treblig.org> <ZkXj9Ip3DoUAe1wt@gallifrey>
 <Zl3_5MzTNqIiXM_C@gallifrey> <Znw2oRnqaZ39aXzQ@gallifrey>
In-Reply-To: <Znw2oRnqaZ39aXzQ@gallifrey>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 27 Jun 2024 09:51:03 +0100
Message-ID: <CADVatmPWjOEkt+_KQXcyPFQy7651_ZNnxZO2tX2Hd=1u20eEEg@mail.gmail.com>
Subject: Re: [PATCH 0/3] parport: Cleanup some pre-devmodel code
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, 
	linux-parport@lists.infradead.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 16:41, Dr. David Alan Gilbert <linux@treblig.org> wrote:
>
> * Dr. David Alan Gilbert (linux@treblig.org) wrote:
> > * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > > * linux@treblig.org (linux@treblig.org) wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >
> > > > There are some remenants of the pre-devmodel code
> > > > still in the parport drivers; try and clean some of them out.
> > >
> > > Ping!
> >
> > Ping^2.
>
> Ping^3
>
> (Added Sudip's other email address, and also cc'd linux-hardening)
>
>

Apologies for the delay. Somehow it missed my filters.
I will check it by this weekend.


-- 
Regards
Sudip
