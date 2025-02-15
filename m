Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC678F4ED
	for <linux-hardening@vger.kernel.org>; Sat, 15 Feb 2025 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578759; cv=none; b=fV+CR791WOtfx8Z3Ga/voTrZADtCxY48h6Eixhlxt7w9RCEXThLvWassRa0aCRLUyt+KTDGadUQV1So5EDH1g1G5KptK3Z/spds3KuGlaua2AM7WmNhrpswOTH69wZohP0h195Wka4RIHd6lWC+PP8myT2R0w4f3QaRRwvJVQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578759; c=relaxed/simple;
	bh=O2tvnMzyYuYGftivul7qYP6BPi4zhVaLHH+PnG+WSM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3m69k4HCSYY6MNqRgb6oPCJ2aQDxui3xIsKmureRRhFdxQ5Zdayf3wOzUGBMSzDCMC678baqsNN0FGV+GBRd94wwU9uEd7gCDZP0mto39zej187a3QnoV02C4p5i30szjY5GToWNYBuQGvg8NMrurfVFUOFV1aG1nxDr/vN63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bYKfgHOt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bYKfgHOt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f4dd756eso20898475ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1739578757; x=1740183557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlkEOzBJttiZYZx0MOJP84lKuZBNzdQhI1Jt7Pa3DyE=;
        b=bYKfgHOtJ+1woBFj/say+DjvvVoOtF1qWiUoeHJgsxAOc6/et1isAXzFPbJSkR+xo/
         bPxFN1NFbcH1cMhkBlwtZgQLxcdaj/5Iy1KmydWBFXEdmk/8DyYBzxBymimS3+uevrhY
         WVmNwtICTusM8XcZ42yXCvaO6h/qfsMFpJyWu3SBlmvYnv5YdHtZNDezUqESH84FuumP
         G/SPp5g9dHSJhNjSwp6vY7YHkID+0czXEhQZnvIc0yZYVNQ/mTSgeCfX/OPBBV2Izh0+
         7LkGq3AMAFC9KcojfrPNDSP2ami5ZiRWoDBS41l93V4axxaDjx6eBvN7ThY+/STbYDGL
         F9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578757; x=1740183557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlkEOzBJttiZYZx0MOJP84lKuZBNzdQhI1Jt7Pa3DyE=;
        b=haaUVnB5vCJGIVrPftfGUPkO1oYupPUM0gVyLzo5qBxGKoKfWmykMCI1Ydo6GCbJuF
         9seHA9ePz7tnyBolBzvGmYY5MesQ4HavKBDVZXhgdOz/yvU6GgwbXgK0VdOyRf60YaUx
         sM4d987N2a4rrFlv8DpiTpXP8GqTlWKncmiH2/jgSK63jq4lNZMnAk2bThItGTS7Rub6
         9jUlyBXl2Lz3IBK0ihqvIxtX8cQkCSyMVm1bM/Zp7/fSGISS6wYlZxhJoqiSMhcUFOY7
         7XJHxWSKi8LSITKM1593rr9dhtR12jisBmh6NsgIhLYDM9zhCnKQInqUrQ3ydD3AtFM3
         hXNw==
X-Forwarded-Encrypted: i=1; AJvYcCXvDRXz3uO1g2mxzZiHLJE0zsji9QdNeCfbMxpt1g9E/F/07cWS7jAPfh8y0ouMI5Ydh2VmP5L50ohtYs5U7RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgB5ITuIiO78aNJBcyGk8BkQP84iIp1251NOCtsZNSnhkZ1ct
	ZTM29R9x6sMo6SQhTwQHaR/fQ3LIOK8HbEemXP2Nwj1WDOOyx5fWxBrAvzZ6SQ==
X-Gm-Gg: ASbGncsxVjChg8EYe5DpzwEg3H67NrKWuMG8lNry5Cw7/Y5kczuwrvz9WbgwN1I+ZhP
	Dv9rzfQONCJZR+aqHhShL0Pq7UBxVYqNiDjOKfsGtz+r374tYD9K6A+yKnYr+tBPKqvkL6TeeX5
	7yvnhejPlPy10eK9e2GXS0SdI3ScIEKjdn6kJ4BN0rPWZLVR7op/rKW0sLWdF9A0/Rr06Ccoeah
	mty7Ju3cxi16ebYZ1o23oM9w0+EEfUvkj/TFQpsN/AeL+DAuCsrmYOw0JkilhZd8Adz+4F4a328
	Og==
X-Google-Smtp-Source: AGHT+IHdV26tckBo8u7d7SukKEJCuBBZmtPNna4QDtQ4xtZWApTjMGnTgqn9ID5uRxOD/BD5vTChew==
X-Received: by 2002:a17:903:2f8f:b0:21f:515:d61 with SMTP id d9443c01a7336-22104028a15mr19666095ad.21.1739578756856;
        Fri, 14 Feb 2025 16:19:16 -0800 (PST)
Received: from ubun ([2600:8800:1689:e500:3522:b69b:bf26:8dfb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491c9sm34177315ad.15.2025.02.14.16.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:19:16 -0800 (PST)
Date: Fri, 14 Feb 2025 17:19:13 -0700
From: Jennifer Miller <jmill@asu.edu>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
	linux-hardening@vger.kernel.org, kees@kernel.org,
	joao@overdrivepizza.com, samitolvanen@google.com,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <Z6/dgUoZdpagGH8k@ubun>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com>
 <Z65/Fpd9cnUk8TjE@ubun>
 <c2af5771-1c16-4ac8-bc09-c33d07956358@citrix.com>
 <Z6/auDKBF1E0m/6L@ubun>
 <48212481-75ef-43e1-afa1-ec1d603a91a0@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48212481-75ef-43e1-afa1-ec1d603a91a0@citrix.com>

On Sat, Feb 15, 2025 at 12:11:17AM +0000, Andrew Cooper wrote:
> On 15/02/2025 12:07 am, Jennifer Miller wrote:
> > On Fri, Feb 14, 2025 at 11:06:50PM +0000, Andrew Cooper wrote:
> >> On 13/02/2025 11:24 pm, Jennifer Miller wrote:
> >>> On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
> >>> Still, I hadn't considered misusing readonly/unmapped pages on the GPR
> >>> register spill that follows. Could we enforce that the stack pointer we get
> >>> be page aligned to prevent this vector? So that if one were to attempt to
> >>> point the stack to readonly or unmapped memory they should be guaranteed to
> >>> double fault?
> >> Hmm.
> >>
> >> Espfix64 does involve #DF recovering from a write to a read-only stack. 
> >> (This broken corner of x86 is also fixed in FRED.   We fixed a *lot* of
> >> thing.)
> > Interesting, I haven't gotten around to reading into how FRED works, it
> > sounds neat.
> 
> Start with
> https://docs.google.com/document/d/1hWejnyDkjRRAW-JEsRjA5c9CKLOPc6VKJQsuvODlQEI/edit?usp=sharing
> 
> 
> Then
> https://www.intel.com/content/www/us/en/content-details/779982/flexible-return-and-event-delivery-fred-specification.html
> 
> ~Andrew

Thanks, I'll give those a read!

~Jennifer
