Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE564C7C
	for <linux-hardening@vger.kernel.org>; Fri, 15 Dec 2023 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeohEGj+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so156317a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 17:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702602098; x=1703206898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvr2Ur0H3dtPqApD/6gE9jtcOvzoERwrapX5poAQqaI=;
        b=EeohEGj+944dr4O1GMAii4oeeRcmUQHTT4em5So9vMXhfGenfJfu3HvDDV4OeAW0km
         zmTe+kWAu6gun4XmeFwg6O+HVHQHk1ANEL3rdv5encFZ5Vz9J4gX/Ij8KYIbRhpDNoNo
         8U3LVfSg26fhgsZ9mtCOvqr1DOzDY7GWezl5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702602098; x=1703206898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvr2Ur0H3dtPqApD/6gE9jtcOvzoERwrapX5poAQqaI=;
        b=jQH+sMuFR/14DsFBBGkljkREf2PlhXNcO4gltVTyRPitNqHrVuzKLT3zus52sTJ7Pu
         w3i00e7VUdMjKwmuXIIGzup8tPwKPvhSY11nr3nsWYyGBwtPKsbv8oxQEp2x9BXIiiBR
         OORwZDbb2F62RqGeaRoW9GomBDrp1QE16yXkh8njrOy7UQJ3ix9TP0QbhQs3wjuPnee3
         XJHCMJcsT+hKP+E7cmf7KPEyDfVJf6FKIfR9V1nPsGuQU7xQP2GuvX13Y3EVAMRKxEvf
         dGB5ZODuasfN6XK0ZEv558TDPHiM/x357M7nK+Jut0QYGSA27yKJSDhVeHWDfkne+b9B
         ef1A==
X-Gm-Message-State: AOJu0Yw7AxL810MCJyt7EWDdvUviAELHQ7FXFRBdaT/Rx+z3TjfYtF00
	xi3YQadgkEDg47niI+HIwEb+Fw==
X-Google-Smtp-Source: AGHT+IGPtVL8rYlBWund2Lz0I8x1zZQs9kji60WlH+CCspE9KSHZwJ45Nu85BYXTCizpJr/Irv6Z4g==
X-Received: by 2002:a05:6a20:8f15:b0:18f:b899:21dd with SMTP id b21-20020a056a208f1500b0018fb89921ddmr14531192pzk.47.1702602098050;
        Thu, 14 Dec 2023 17:01:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b0068fe9c7b199sm12351686pfb.105.2023.12.14.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:01:37 -0800 (PST)
Date: Thu, 14 Dec 2023 17:01:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Report excess struct member
 descriptions
Message-ID: <202312141700.E0BC0FD19@keescook>
References: <20231215001451.work.746-kees@kernel.org>
 <16d1510c-fa3e-4fa9-ba4d-c483a22f83a4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d1510c-fa3e-4fa9-ba4d-c483a22f83a4@infradead.org>

On Thu, Dec 14, 2023 at 04:21:17PM -0800, Randy Dunlap wrote:
> Hi Kees,
> 
> On 12/14/23 16:14, Kees Cook wrote:
> > While missing descriptions were already be reported, missing struct
> > members were not. For example, previously this output was empty, but now
> > produces:
> > 
> > $ ./scripts/kernel-doc -none ./drivers/leds/leds-mlxreg.c
> > ./drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'
> 
> I just made a patch with similar functionality last night:
> 
> https://lore.kernel.org/linux-doc/20231214070200.24405-1-rdunlap@infradead.org/

Ah-ha! So you're as confused as me about where the robot was getting
warnings from! Your patch is better.

-Kees

-- 
Kees Cook
