Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30569173343
	for <linux-hardening@vger.kernel.org>; Thu, 18 Apr 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462043; cv=none; b=XzDtv3kmk9ay7tqof3Fqp1Ps/f5gV7FtwL968MOJN8MyFEwfOvRT6xv8xoXYQEsMt1OniJKBAvDlW0r/ifKcNmZ7f75roodPIcWp4qcgxNY916UlSmPYdz5xFbw3Rdl2CiHf17STTE7ddp98D/l5BUerS0jMkA6sq2k9aaemTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462043; c=relaxed/simple;
	bh=FmPKRIB0vDy4zhpyj6WsFvnKmu3PIPghHZcwDpm7UEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAxYHMWDaRYq1GzJW0vdl810flZ3uR++fAQzg7zCWPmtJl+FP8TogBI3hidnEtp8w/z/LGUsRul8s4TR15avVlQZkQ2OLPChbnxtIHJWyklULopMGD4KQQl7zTwdUzBllZczQ7OYCDHbKUu/Aos9FBLr9SwA26cb+JgouVikhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iv71FbM3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iv71FbM3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a78c2e253aso987486a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 18 Apr 2024 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713462041; x=1714066841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTqhhBAtzyk3Y9s85bxHLdZZZetoeXscUaMMXvGt+IA=;
        b=Iv71FbM3sqROqfmgrQCVYIxSFOCYldhNEV5t5SMg4dygVf6l0xiy0AhMGQg6t5aEVH
         XeXnDcsYEMGGIKXlAqR7XZhGmnj+G8HKInS3vi24KDISE664b+MxpQNi7WCmECpsthrf
         tyq4fDK85fQFZfJQ5PbeVBz+8srtNXfI6fvPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462041; x=1714066841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTqhhBAtzyk3Y9s85bxHLdZZZetoeXscUaMMXvGt+IA=;
        b=tIu3PCeVgcxwohUo3J10IuZejNf7a+YkfVgLyX2EJJgq9SdBOFCrQrqG1b5LnQLkdq
         YzRX+E9nrpfIpImeFoX6TkDhK+siG++bZCmUovmE70K1HQQB83jmsBYNjCsXcIhapJQX
         4cWoHnwcc6nXm3bOpZhXrXP0lsZmSYf2S4SxHxdvFj4vCOGAJ6XxyXZSzfro9FFiBD2N
         K+sg27qX5Yd7BFQsuMHLg+PlW5JN/QVeRMJUQvL6Mx321yc0U34FjGCQC5ect9roFvu1
         h+JMIoXE1uQhbq7mebdK5rniTAJrrRu70smn2Jq0IwO9ncVPZ/zN9JMpVsN+jCCzXdCL
         HQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH+7Elqmd40hOIJrzWVD4tQdbSaJb20lsu+QWNAhJ+uW7V32sBZKjgYQezg2CpdH+D6cwkhssLWD5f7yV40MuqTA8Ii4QfO1b9UoTAkOvz
X-Gm-Message-State: AOJu0YxXco4/P57TxnM8IWGG6p6XCrFmzAgwmXTrpNzOSpJCvlneGO6T
	3Tc01MdiHkWo4v35S44kjm4zJdjFOCox1p6CraFdrdkukZFhiZXbPK0/BgSCWg==
X-Google-Smtp-Source: AGHT+IF/jJgvVvcAiBGDTdy1S/NUp/TuYY23Ix3/ItUaAh2s9FW406qVNmGBDyZHak2a+xJEHWf2jA==
X-Received: by 2002:a17:90a:4894:b0:2a5:4d59:950e with SMTP id b20-20020a17090a489400b002a54d59950emr3243619pjh.27.1713462041529;
        Thu, 18 Apr 2024 10:40:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b002a2a3aebb38sm1861443pjc.48.2024.04.18.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:40:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:40:40 -0700
From: Kees Cook <keescook@chromium.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Charles Bertsch <cbertsch@cox.net>,
	Justin Stitt <justinstitt@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 0/5] scsi: Avoid possible run-time warning with long
 manufacturer strings
Message-ID: <202404181039.1457626B@keescook>
References: <20240410021833.work.750-kees@kernel.org>
 <202404171035.BDFF28D@keescook>
 <yq1ttjzecfv.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ttjzecfv.fsf@ca-mkp.ca.oracle.com>

On Wed, Apr 17, 2024 at 08:35:15PM -0400, Martin K. Petersen wrote:
> 
> Hi Kees!
> 
> >> This series fixes all 4 of the instances I could find in the SCSI
> >> subsystem.
> >
> > Friendly ping. Can the SCSI tree pick this up, or should I take it
> > through the hardening tree?
> 
> It's on my list of series to review. Have a couple of fires going right
> now.

Okay, thanks! I just wanted to make sure it got picked up for v6.9 since
it fixes a real-world issue. :)

-- 
Kees Cook
