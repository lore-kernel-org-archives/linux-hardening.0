Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E336EA8B;
	Thu, 30 Jul 2026 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378946; cv=none; b=qD54eGf6JQLFUVNEJft2ee513DMYA28EruyWrUxdC26CWwzWEoaXQAiLRZ9loilfILjMzwVFulTkLHpKoS2OycqL7FIAl2O2V7w3pC7MrNYQOGvtMmBO9ay9KRe6l6mgYqV89tIKvxyxou//XtFT0FdkpmyIqrtv7wyJUEJ6QSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378946; c=relaxed/simple;
	bh=QA6hVIEAHNiGkoskLuMDFBYH91/GzfStig5+RxuGzpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRQkBrkGWAkdA9fbbFMb1Q8yftHmTX827ZbQsgWiFyUKs5PeNIfMwp8WfPYqifAn2rjRLWdL9jcUiUn4O9ItyiYlnlMhm0E9p2I7GgxOoyCi+nAeUCJo2eLKkNAWDw8gTYzyRep/2O/KRNmxAtGsYc9joJftHIhEWqQr7Lk/Vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=BoeB3Oga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIw4QHjE; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="BoeB3Oga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIw4QHjE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 404C31D003A0;
	Wed, 29 Jul 2026 22:35:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jul 2026 22:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785378941; x=1785465341; bh=QA6hVIEAHN
	iGkoskLuMDFBYH91/GzfStig5+RxuGzpQ=; b=BoeB3OgamhK4p/+XMhswxELE6D
	fNwKZw+Ju6l1ZpLcUFxRUPm+XoUzNLYF1RQd6043iEVdF4anZQWUbT3aPS+RAKj4
	J47cjGyogU2i8JsjcGmipds/28J4d6so0oNPM7rfqHQH0uxMobhgyrGExb/+1/MJ
	YyMSJTzjRjFQI4N5wUp/G08eJB/q3gvSUd7/bU7TxPqEQDOHLa0+tTaxOqZpKH+t
	Sz6iwZEWiJ0WbS3oXox3uzWZs1aEBQoVwuo2UgTENlZGUXj4dFYdUad72BsUAZMJ
	iu6bAp/8CjtPnLXBsb/TFl/93sYSF39WA29cj8pBJwS9h47t6jTNx1E0Ar7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785378941; x=1785465341; bh=QA6hVIEAHNiGkoskLuMDFBYH91/GzfStig5
	+RxuGzpQ=; b=eIw4QHjEKLYfx64x2KiaeyDzxS7j4sN/Js4+v7JoRmw8ERp+y4U
	7SPIRjd/cri3QPBcTRkaeYvE9Wu8n6yiNQU01fWIYCtaPK/1JjGFvzRVkqapMquM
	uaTK4bMx6iZZfofUYMFRgJ8uqJAq0SvGd9PFzJMhPhethD1mqhL0sqLYzmeittAa
	KYRDPZR2Kcr9oItCepiJ21C2JmiAFHBSAnJCwADmuQjHquLwyiB8zMybRHcgsCEA
	LFviGvdZhM/vVpW/li/9TjgIaBxE8oDN92RYEXPNEh1Pyy4QlUGyH+Fw66fKNAU4
	+PhtvMfCXxXztUJQ0ReH1nzciL+rjaPM5xg==
X-ME-Sender: <xms:fLhqanUjJMIEhJOMYL1dmmWRctBy5rVaT8E4o9VyJm1PTm30yO6Sug>
    <xme:fLhqaqhVStby5b2rmx4AS8Q-8Mz8riH-3w7Ui-jz5XTsU6xezw1CdAFO98ZJx2W4T
    meiDefYzfWILCWot3fNTPbjUXcvNF-oqJXEv8tdk_eluL7lusxpf3I>
X-ME-Received: <xmr:fLhqaibfg7sKZIKyKlLRNw-QqnviSdleJ20WOb3Fy3RN7cboSQiWuq9M5_A>
X-ME-Proxy-Cause: dmFkZTGX8nPZjomJll/+jmV5dmvE9dRvm7GU9Q2cJ9xo+eUbTuc6GG6qNQ+SB1XZfeXoQZ
    O32aTzHIw2tKNTqeYNRNx1jUEPc7H9bznlRG1xEJZb7RULR3j+RSa+qQowZFdt7y3euXka
    uv2uky23BIqTpYoDVqX2xTc27fbT7Xlst+7LR8iNKpAJWIrKNDVUdWhTbFRULphEvX199w
    ebf+ac+hMeGx3kzMBBnf16i/xOF+FDnTQ4zLkmpUZ/yOs2bSM8+Fx+zYiQ1Q3fm570z+AN
    2gdNT4/wWFA5eLzBW9HrT88hqvziOob32LcEK+IstnkmomQk5vxHAWFEUc2CUcVTtaFujC
    qz+homSLfYa1iBMxkWzxzBOJWxrQnlsuypyYhipcO1UBMNmeNDC7aoxAcvh9bzWt5Kmnrb
    9w9owfdKdvXWcL6OIjkQ5swr3y0RsBKAH/u8w7eUwKADR/0hypTpOu88Ioa2GvxD1z0ed4
    FPRtBmaWNtX/k1jabNXvdXEE3Jsn1b0YlhUgiNBya1ND4qsRZu2a8xpibgkwYfzD+210Of
    kcjJKFumIVYdwF932fkvMpwFDlGEcnb3RT1O7C8v9/rmRjNkDKuChBS1N0TLe+LZy18rXs
    aCXwUpaL0p0buSQkt2gQvk3oXqSP+7Yf3LQ4QyzkT7BgcmYPTCE1ov1Blwfg
X-ME-Proxy: <xmx:fLhqanorePvGxiqHK-QaStDBT23_3mqcJbiGnLAPWGgUi15nZVtkIA>
    <xmx:fLhqavP69dRAd9Jjb5KwO83dwJ65nK0a6ak5FPEEsbFQh811vYTaOQ>
    <xmx:fLhqaqqZ5UyEz4nz8su5W3NL1ndj9FJE00bDUQoB4Hem5l561bToQA>
    <xmx:fLhqasf9PWKz-TQ-3JeNrKjfr2TyDN2tq3hEKea90-vCCYsjRiKVhg>
    <xmx:fbhqahZGnLAkPSquH7CRJoSrdh3vwKaI6Wx_QmVFdim86SSfC672wUB4>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 22:35:40 -0400 (EDT)
Date: Wed, 29 Jul 2026 21:35:38 -0500
From: Ian Bridges <icb@fastmail.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <amq4ej83V5e7BRqh@dev>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
 <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>

On Wed, Jul 29, 2026 at 04:00:35PM -0700, Borislav Petkov wrote:
> Are you in a hurry with this or is there anything that needs immediate
> handling?

No, there is no hurry on my end. I'm still new to this process, so if
the ping was not appropriate here please let me know.

Thanks,
Ian
