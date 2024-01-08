Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B556464
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jan 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yb8RtHfE"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1798156a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jan 2024 14:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704752912; x=1705357712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIz5GdX77lFb9OhsM/0GWdi8bxP1o8+l8qU3iYNTkSE=;
        b=Yb8RtHfEoYjzjdKO1D/wsgNTBukl8fQvr4jlvb9SNUSDR1jtZ+4NKxCf+MlzSqax3f
         sGKOiq2ndM5uL2102g2cFSftnInPGvEjhgAXgyXrSW69x4RhVQ9YUo+bigRpSBKdVdQP
         niCZJwFjvD7rs9DOVDhPTPQZP4okiebXlM9Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704752912; x=1705357712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIz5GdX77lFb9OhsM/0GWdi8bxP1o8+l8qU3iYNTkSE=;
        b=Gfuw6Wrxz6k7dbyDHpBT+w6jXDj3FP2bSRPEV48XWTVZfgPMMrx19GE6MqZ4drNhS7
         /15XxdB1zE2t1UG2Vwh0Ekb6khd2zG4fu1sAHLU1x/Pdex2cUqKUbTY8FQofYJwf4ScX
         zFbGKBUHGnGFMX5h/QwF44sSVjGKKWtP3BxTPN7CamzA3e8S5qxjuRwZ+RTciYMqY/Yi
         qRW4rV8dl0ru6I6+Zj9uMc12yGj4rTEzYJNdWKhKQES3LtiUuZXhNIRYZl+3fWGUpe5D
         XfUU4AnKG3nUBLAvRB+rXvaj09LIT77z9g5lpGv+MXjApFHYQbNQ3y0aLjXOBmxkut1E
         II3Q==
X-Gm-Message-State: AOJu0YyWfmj3fi5swWweBNhTWrpBnUH0YfOZ/Eyuqz5C1HDXukpeVlRi
	2fJJSY157T1lsQGj8hd80/Y+F9r/FIwP
X-Google-Smtp-Source: AGHT+IFtKmKYgClXz3t7LX7s+lUEissTL9t51VE4k00tztjPyrp7lFr66tearov/dGpx4eZr9Vy+dA==
X-Received: by 2002:a05:6a20:2589:b0:199:dd55:1459 with SMTP id k9-20020a056a20258900b00199dd551459mr934233pzd.81.1704752912438;
        Mon, 08 Jan 2024 14:28:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b006d9361fcfc8sm367358pff.177.2024.01.08.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 14:28:31 -0800 (PST)
Date: Mon, 8 Jan 2024 14:28:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, error27@gmail.com,
	gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com
Subject: Re: [PATCH v2 1/2] VMCI: Use struct_size() in kmalloc()
Message-ID: <202401081428.F7A80008D2@keescook>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>

On Fri, Jan 05, 2024 at 08:39:59AM -0800, Harshit Mogalapalli wrote:
> Use struct_size() instead of open coding.
> 
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Yeah, clear replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
