Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63967CA7B
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0e41A1v"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e60e13703so1589995e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 23:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704957344; x=1705562144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX20rbF7hlnyWLHyXsogEXaIvZyHEjXlNvsR8Qs9blw=;
        b=r0e41A1vUzhV8KYDP89y4Z08jMC7CEQQfR4ANirMUE83erDaIRq7WCKXYEK55Knx1G
         WI8gHtgn9qGk7ZO91zsBAQYYZEiVki+liCxRmN6NbwKmO3K+eLc7YyzG/+zOJZUMhLzL
         Hsl1SZ81BbGW/lh1ebS8Bi+BjY5w5isG7fyPnWTMG5kcmGkYAUwJ20EdOqWTTBNrSwcR
         R6KIQHUUt1NEwRWfPDZxIt6P1WX+Slu5pPTlAeYaNsjiRlnfGBaXS/zdm10AkDQmtTzI
         QC90PSoas1QVIS1LnBleqc7AHJBPhs012ATidlDsxaR1JqbD0qmskbvwYIuy+uBcB0tQ
         Jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704957344; x=1705562144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX20rbF7hlnyWLHyXsogEXaIvZyHEjXlNvsR8Qs9blw=;
        b=Wtf6WoHMGMFRKnYkhFrUsjG8j6cNQSsqqDdTnU2PoPIbAUY5FiZRXBKhw8lKZUpJvb
         6UokbxHTq26u4iBU2e+NWruB4hE2fXaCr5UZ6l30Hmoimi4cgAmg7N+DY5VdhefK4aAW
         ysEGUjQXdO2U5lJalLx4rYcb6EgK1tCPojLZz5D655ZN/Rpl+MX6/RI5Hne7M6t2pDDa
         GRq9uqIQzNHlCsL7R3Ss2mfisRFoRJAkaVUT1ueruGdjegdo6f1wUb0G+awu8AKLS8MS
         orLkP5YubL+WG6Wlmd037ZwFE5p4Z/0CPUJwme1OcMg7B7XEqAf7wki4KQKu+80vG1N/
         BNQQ==
X-Gm-Message-State: AOJu0YyBRcU2cm7qblMa2R1fqrzLcMAP+FRAVK6iC5okfslIZsllUDMa
	E9mjI1WQZ4r2JpeNh2Jyvp16ib6V9zmnPQ==
X-Google-Smtp-Source: AGHT+IE3ZG9N0YdyCOamkgAPvxJPh1uuI47g4YgkEb/vAmbAgIDLHmccrGJ7hdBP693w0AFm/dM0eQ==
X-Received: by 2002:a05:600c:428c:b0:40e:52c3:47f9 with SMTP id v12-20020a05600c428c00b0040e52c347f9mr122255wmc.67.1704957344497;
        Wed, 10 Jan 2024 23:15:44 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600c450500b0040d6d755c90sm741939wmo.42.2024.01.10.23.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:15:44 -0800 (PST)
Date: Thu, 11 Jan 2024 10:15:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <8e527ade-fe49-4697-8e36-589775c63354@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
 <202401101601.30ED61A1A3@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401101601.30ED61A1A3@keescook>

On Wed, Jan 10, 2024 at 04:03:28PM -0800, Kees Cook wrote:
> 
> Oops, yes, thanks for fixing my confusion. Right, this is a direct write
> across members into the flex array, not a composite destination. Yay
> all the corner cases. :P

Is there a document somewhere which explains what will trigger a runtime
warning?  For example, if you write across members but it's not into a
flex array does that cause an issue?  Or if you read across members?

For example, this line reads from bulletin->vlan and
bulletin->vlan_padding.  This causes a compiler warning in Clang and
GCC depending on the options but does it also trigger a runtime warning?
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c#L2655

(I wrote a patch for this a few months back but didn't send it because
of the merge window.  I forgot about it until now that we're in a merge
window again...  :P)

regards,
dan carpenter
