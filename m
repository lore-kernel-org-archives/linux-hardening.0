Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5F46556
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jan 2024 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGc2EARI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da9c834646so1950914b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jan 2024 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704753442; x=1705358242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOcszfoOtbrQymFXSK9IHNzongPjla6aRzHiR7rojiM=;
        b=IGc2EARIQIIB8O6Vm+GdRoHHDYEJGZtAyNrfiAXZoVqhyFaB0Veqo74kzPpzCO8RFS
         /OKocbHnarCKal10551hsTCP/ZFIxrFdncYeXTPitXkvTOTZYxJF5614Ou7o8g8wNh+3
         dvJ17WZaSLtZqIqJQYVmnVwxq9iDq1rp5qhQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704753442; x=1705358242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOcszfoOtbrQymFXSK9IHNzongPjla6aRzHiR7rojiM=;
        b=nBvlxNO/Vt8y9b+fvZ8CJpsaD9FPIIQkqyqpT9+s+psYplgDYFfrPmbiYgyUpK+sp6
         bHNZYVMc7s/ydpWt/qscssCB0BcVsqfOInEzuNN1ZEZMaIgknn9AbH1soEiHXONOAYBW
         O1n9yhcQTp0/gApO+TTtbIS9UPCpUPTRC8f5eUhLVC5/F10+btHRoaKXIh9H/J2yBqLC
         xoBWhQAVA3KxrRrVvpTxLzUv64UXpQNxLVr6OkFrOdsuPItQMrFNZuDhVviNPLhioOGj
         36FJJGwhx7r9Qk1EWwXyvWTL4hZtHH3s5vCjzge0oQ8OiT/JQBlf9hPp5qcSW1n8vzoM
         8zlQ==
X-Gm-Message-State: AOJu0YxbmS0Hnca3iYOjFM8YfqI/ElHIvYLWuBdej2JrmEHLobioEUHG
	H8lPufA/sKaJkV1bPzLO2r9Rs8WiROtU
X-Google-Smtp-Source: AGHT+IFP/0woPJW4kQ+yzruCF3Cc0DegNJgknG43JH4U2qEr64erAh72ZUJ/E06yo2UVpK10LH6AJg==
X-Received: by 2002:a05:6a20:12cb:b0:199:9541:c624 with SMTP id v11-20020a056a2012cb00b001999541c624mr4433828pzg.101.1704753442384;
        Mon, 08 Jan 2024 14:37:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a14-20020a056a000c8e00b006d9bf45436asm362084pfv.48.2024.01.08.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 14:37:21 -0800 (PST)
Date: Mon, 8 Jan 2024 14:37:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <202401081430.9DAB37B46@keescook>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>

On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> 
> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> 
> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> 
> Some code commentry, based on my understanding:
> 
> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> /// This is 24 + payload_size
> 
> memcpy(&dg_info->msg, dg, dg_size);
> 	Destination = dg_info->msg ---> this is a 24 byte
> 					structure(struct vmci_datagram)
> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> 	Size = dg_size = 24 + payload_size
> 
> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> 
>  35 struct delayed_datagram_info {
>  36         struct datagram_entry *entry;
>  37         struct work_struct work;
>  38         bool in_dg_host_queue;
>  39         /* msg and msg_payload must be together. */
>  40         struct vmci_datagram msg;
>  41         u8 msg_payload[];
>  42 };
> 
> So those extra bytes of payload are copied into msg_payload[], a run time
> warning is seen while fuzzing with Syzkaller.
> 
> One possible way to fix the warning is to split the memcpy() into
> two parts -- one -- direct assignment of msg and second taking care of payload.
> 
> Gustavo quoted:
> "Under FORTIFY_SOURCE we should not copy data across multiple members
> in a structure."
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks for getting this fixed!

Yeah, it's a "false positive" in the sense that the code was expecting
to write into msg_payload. The warning is triggered because of the write
across the flex array boundary, which trips a bug in GCC and Clang,
which we're forced to work around.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832 (fixed in GCC 14+)
https://github.com/llvm/llvm-project/issues/72032 (not yet fixed in Clang)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
