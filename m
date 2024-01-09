Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDA2E834
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jan 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwCvysMn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e461c1f5bso20320745e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jan 2024 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704791282; x=1705396082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj5iNAb0vOYUNWOsVLfq/Kug7eJUVIVzh2hyRWQ9KUw=;
        b=AwCvysMnVtsr48eVgqGW/PjoXAEIMAVqxjxtgNU488yAk3Emg2FaAirTIL4vF99jKy
         GVbJqP44qutP2j8L+QCu1D080k9cedMcScSVuwrmtLIXgbyVRY0U4mousSVKDs3/GVHN
         8X7103W4uytsOMZwextInwpNvHJk5eBqmunefOKluAsiFwiVo45XlV3AmzSS4GiNYKnA
         6daDPp35WIl6ZX9IHNImLnErQKkm6RZLp6saf4eCSUoCG3ULYePG7XEFQh9FHtE+Qif7
         AsTQ/uWNvYyB27unCU3ieThkecAocXcQLZ69kChQ78mSrBCajfNPzJiN2fNyJLr7fjvf
         Lv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791282; x=1705396082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj5iNAb0vOYUNWOsVLfq/Kug7eJUVIVzh2hyRWQ9KUw=;
        b=UDlqM7WMOgZn4XrFadK7z8DLbDIuB1HaztJI7IfERizaO+eMvt0qo4J98ZIpL8UyUo
         6X2rn7b6R5xkz56Jo6lVt0LZ48/UGx3pnK5sWdpb5bWp1F4eKbgjqLXlXC1SFjByjLN9
         ZNdeaZRF4i5j3j2BOfc6huMyn+2+EtESuiqb33CvEZa/1sewk7MaEkklFjonJBXHbPia
         QcBiN0sTo++ouSvi6NWAwj1kJv5QpLXHf/rT3Qw3axSV912H5Vl6pohKj9koVp8U/Myk
         GfetEdHKVxn1qo8DMW3pXECVWhcNxkajiqLvsSpe1nbkXj0W90rfaluNuDW7iT3fNhOe
         JUnw==
X-Gm-Message-State: AOJu0YzdxXRENCUbVEFJ5KV7St1MMssHDD8C/eeIb55od6cLBT3IOq0C
	LZWF6d0po6WfKz5kZNMeC0LS10m/gYRo+g==
X-Google-Smtp-Source: AGHT+IFHr1mJqGahwdyos7RzxqemoTzawy21RafqWjIQm4z1Kiyj0E+rFrxLMMz8BuQYnHZmcXR9dQ==
X-Received: by 2002:a7b:c34d:0:b0:40d:88c8:25ac with SMTP id l13-20020a7bc34d000000b0040d88c825acmr2507343wmj.48.1704791282280;
        Tue, 09 Jan 2024 01:08:02 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id cw16-20020a056000091000b0033753a61e96sm1828362wrb.108.2024.01.09.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:08:02 -0800 (PST)
Date: Tue, 9 Jan 2024 12:07:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>,
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
Message-ID: <79ca2f85-1f8d-4a12-aa5a-09137033605f@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
 <202401081430.9DAB37B46@keescook>
 <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c742547-0021-464b-b7a8-7af46b0a4afa@embeddedor.com>

On Mon, Jan 08, 2024 at 08:05:38PM -0600, Gustavo A. R. Silva wrote:
> > > Gustavo quoted:
> > > "Under FORTIFY_SOURCE we should not copy data across multiple members
> > > in a structure."
> > > 
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> > > Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > 
> > Thanks for getting this fixed!
> > 
> > Yeah, it's a "false positive" in the sense that the code was expecting
> 
> It's a false positive _bug_, and a legitimate _warning_ coming from fortified
> memcpy().

It really feels like you're trying to sell the cost of this as a good
thing...  We've already merged fortify so why are you still fighting
about this?  Now that it's merged, let's just all admit that false
positives are bad.

I feel like once we recognize that actually false positives are bad as
opposed to good then that's when we start looking for solutions.  In
Smatch, I have code that silences warnings about cross member writes
because it was a common source of false positives...

The Kconfig entry does not mention the risk of false positives at all
and it doesn't say anything about turning on fortify along with
CONFIG_PANIC_ON_OOPS is probably bad.  There are simple things we could
do to make this less risky.

regards,
dan carpenter

