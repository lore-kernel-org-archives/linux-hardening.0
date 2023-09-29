Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2F17F2
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 05:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27795C433C7;
	Fri, 29 Sep 2023 05:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695966437;
	bh=ayyx6diQFCE4/i0OyR9K661Xi1vAvQH2euXiaM8yNm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xbCONu0+/vj0XFwkoWnsf2TqByO3ktsHf/PXDV9pN7tSCIJIk9tQjl2vEa+B1nWTE
	 A5+tlUezN5/nVv+6n4/7lauCZWcYaK8Cgaf3WxWx9rzg9KglKnlNYsXTHhbAG3HpyB
	 7R4QkY8n+gydjVqvK/axYi6fjN1pv3aGeGBtNdf4=
Date: Fri, 29 Sep 2023 07:47:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>, jirislaby@kernel.org,
	tony.luck@intel.com, gpiccoli@igalia.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] pstore: add tty frontend and multi-backend
Message-ID: <2023092919-buccaneer-ibuprofen-7834@gregkh>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
 <202309282030.8CE179EBB@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309282030.8CE179EBB@keescook>

On Thu, Sep 28, 2023 at 08:49:02PM -0700, Kees Cook wrote:
> On Thu, Sep 28, 2023 at 10:42:39AM +0800, Yuanhe Shu wrote:
> - I'd like to check with the TTY folks to see if this is the "right"
>   place to hook to get a copy of what's being written.

It depends on what you want to get.  What exact data are you looking
for here?  I couldn't figure it out and I think I already asked it in my
review of the "hook" location.

thanks,

greg k-h
