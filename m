Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9837107E
	for <linux-hardening@vger.kernel.org>; Mon,  6 Apr 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492553; cv=none; b=uhOqh1720aPyEiTJdSV/UOazA1MJQyI9oMyAYOgqmovMZ7noLnf2WQ98swvir4aK9snGkc88a81CRWQtimycsth1zmG8ujDs2ObS5iglmlk4hdhc4LgH30gK/6k0XOcFnQpgPw4bbKR4Io5o0rHTmCVcfPQ86PC0LaMunPBbitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492553; c=relaxed/simple;
	bh=ijCVD0aiqNDn7jPG5o5A2gGQwTRCME0B7xk89odnK4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=unn7Fkwh2b3VaKLQprds9NrYUCfhloLqb+PCy6dNV4ElKh7OAIimEz1A9VZcPXY9v1UWEzhksCrHBAiJ6AO+2MmGgkgCVH1IyyrfEggd40j66Q9ZqgE5YylXVnFVbqwmUfOXYQ3Uw2yWoYp/02fi8grhCVQLy25P5Y1+vR3Ebds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaFNq6/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaFNq6/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775492551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWslBRf0qez7073VMBbYbm8uIhmaBf/eGLBWgOwRt/A=;
	b=JaFNq6/XRLcn4ySGWkjlWJetnBb2WrNyLGNVKmsiflq4nM4em2wyt6q6gJIlEk7yckDqi7
	cg37iKHr0k5NtDuHdho19k9uWTsQ9K6DXiH/05LfmU4xQ0p2ilmiN00wZEhOhBPHbA2Kua
	lFVGDIm1F7BD6SnH4A+23HutpR07lrI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-EEDAVZHHNF-E5lPKs3WmBA-1; Mon, 06 Apr 2026 12:22:30 -0400
X-MC-Unique: EEDAVZHHNF-E5lPKs3WmBA-1
X-Mimecast-MFC-AGG-ID: EEDAVZHHNF-E5lPKs3WmBA_1775492549
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfc61fc9b8so1027460285a.1
        for <linux-hardening@vger.kernel.org>; Mon, 06 Apr 2026 09:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775492549; x=1776097349;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWslBRf0qez7073VMBbYbm8uIhmaBf/eGLBWgOwRt/A=;
        b=KDa442omPVAytkjvQwHm56BU5guYPCcBGQH5cUIVFxDhtKjo1cLsRRKQIyyHM5hD/i
         gnpz/WXp7XPOg/J1GxrPTWgUjRfZw04e+C8/DiTNnMTB5EzrGxAlsn6cdbxMIs5rgB4Q
         NDrTffxrALaL2cSLbGjigkAPe4jJMNO/iX2FDdUyTt1dWy1c86RMHYbqQnO8e26X+TUU
         o6EBjq8L+zvwHXBLpZeT5Qv3vpL7KyXuIxhkmN0tzKwdFE1OAh+7qy5FvCDMiWQXTf3B
         8bcnYJEFN2Z2hycq/9mfCmZhe4QlXZok8ZcQcfm38fF5Dk9u1LbzNt0UPnJzHq1rXkoH
         yN6g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4xUzrVDJqgWBXwzDFkDQogbuTKyf7iffs1RHWY1L9V32P5KWts+O2V+raJVzX80QmajHBtEo5jUQlqs7YbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+nn788hFQfNy1f+5voo4JLmFY5OCfGPmM41kjwo6GWP7fkTk
	zm31/9CPyXyQjB++jjqiVgB70AKgkmNXUEdVIMrhPAuWRfTBEoSd7yWSxrnul4w163saru6XsYc
	rTQStJzbAGkT0lG2i0oWTsSZe99oxMbMEh+Mx2VdGsqW+6tyoM7kJPUaoJb/tk0LBNJWG4g==
X-Gm-Gg: AeBDievMBNx03sBfdXv73Xnwm3EBBADIVvwj2NI4+QVcC8k8hioZHGjcKS5GWNzwgJJ
	lMGYUUmqjjz3M/I6XJ+Uym/0EG9qmZAApdEmyXDnMmqTSLFX23VZAZhRqzusJhuxTCQ7ddbLReT
	kh/05RlkVxnp1qtlkzMkXmzFYBgn0spN/9xs7gt9eVCLIzhHgac36S2RJU0cxmvJu2FJeHfsOZT
	Ri7ANabz5p6q91sVeGHrkhlJsKq4CHG7OX7LXw65NmWDXKDuy/aDJhYaL8tbl/Y0utW2zkHTgm5
	SW/jz0/dPNuCSarCxnA3h9rjh9EuJqzhfpVrH2bSBDRHnE/tHzqOlzWTEj0KaqXGCN854CFXUiF
	LE6zeStbHVn1mduQS4WW6zycRxmwbowcjOspbATW1Cqmxdqo70bPnNiuq
X-Received: by 2002:a05:620a:1983:b0:8cf:d717:c22e with SMTP id af79cd13be357-8d41c3b4bbfmr1914123785a.28.1775492549544;
        Mon, 06 Apr 2026 09:22:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1983:b0:8cf:d717:c22e with SMTP id af79cd13be357-8d41c3b4bbfmr1914116585a.28.1775492548827;
        Mon, 06 Apr 2026 09:22:28 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5c5cb5csm1099220585a.15.2026.04.06.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:22:27 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:22:25 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] clk: mvebu: use kzalloc_flex
Message-ID: <adPdwTGDdt5MkDp6@redhat.com>
References: <20260403194701.11902-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260403194701.11902-1-rosenp@gmail.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xh5U6MMSr9aNZxYNpnpV7wTj-24kidaqgjhaaKJJChk_1775492549
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rosen,

On Fri, Apr 03, 2026 at 12:47:01PM -0700, Rosen Penev wrote:
> Use a flexible array member to combine kzalloc and kcalloc in one
> allocation so they can be freed together.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment right after allocation as done by kzalloc_flex with GCC >=
> 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: remove now unused goto label.

Reviewed-by: Brian Masney <bmasney@redhat.com>

This is the third time that I've asked you this [1]: For the future, if
someone asks for changes in a previous version, then be sure to CC them
on the next revision. I was the one that found the unused goto in v1.

[1] https://lore.kernel.org/linux-clk/acvUoSOOF_9UQC75@redhat.com/
    https://lore.kernel.org/linux-clk/ac0o7XbBm8aBOa7a@redhat.com/

