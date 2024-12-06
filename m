Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB914A90
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445909; cv=none; b=Vim677brCNqajUzoFZhFGwM4z47o72MDFUR+/isG9TfFbVAVEsF+SYBqBG1WC0Uw8FS8lqLA1rY7Kr+cbuzwOcq/rdtSn337fIbplYvb2y068zuQoSNJvY+YF8/CfT2QrEX0QMH2mu7RhVuVOZ9T/9QEODsN+w4L0DJrKJvMEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445909; c=relaxed/simple;
	bh=gETGwCaOGnK7nQikpyqTQI6K1uu248xeEEWKHxkYDSw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=dPn324SVuI4PriiyiByWvg8cYD1SyKUi8UnRCLsGTEAnATGx/XM1qiQ6HkxpRfLGKwfHEAj54HRJ8s7VIpbs5j5Tw3dTpcb/sm0zs0kHudPYNPiOyfZMHkvBHAyiA44g0yRGsgKTfDuAUxtgTOCuh/n7MMCtUohX/vyd4iXv4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IGOIc3Kc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IGOIc3Kc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b670de79e6so102912585a.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Dec 2024 16:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733445905; x=1734050705; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DAbdRuarLinIGr4f64EbY2TJW33duoe/lFkiR5WKEc=;
        b=IGOIc3Kcin8EAENMxtzQJ+KPSK4f2lfRNvDfvhzIWVGNmYNZOcXYNFcvZzjJPxpEUi
         GngKKn4yhJMWCaJzWFZ3fKneA18ZHPFiMq23Sfi/mSLCyFR3Q63Wq/H+cP8b1NY14oRR
         RTKnZnAmwjyOWcnmyLLQo9QgkXpGkVDGsigQE1DElN5/zLfFdeM+rYO/FxAib2vTP/ec
         SHcSmhplBpb9jnDds5zPNrerh0HOYzjXR70t1RIi6IlVypmTncSBxtXwYDiyKX08HlWR
         Uhhs5hc28UA5gJdzxgrGzpSwVs/6pgD0QCCuYTBG2SlhEtwaGbOSyPGmAlCQdVQhzU4Y
         tvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445905; x=1734050705;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/DAbdRuarLinIGr4f64EbY2TJW33duoe/lFkiR5WKEc=;
        b=dv4ZgP2EmJVX3x1aZsXULjmr/lsWPzRJDb5MPmQdsQvAJOMXWVNiaAf2jKqwhnkrNF
         0ugTmL1zJh8szCozR/AXowFJnLSwpJFqig5YG+C4WvY7Os2C/FFXo2JQzcVcO2t/T4z2
         S1LQVABoJbO3nkfnRHzxl8zEh01x2jgwdQhnOAN4DL8AHo8YUGudy92IOUIGszSS/x6c
         saaNYrvSmSKSpf7Jjffvn1WjBZFZBvXqtL23TEcv8cS2jgnNQcd8d9Q+/mltzPXWGf7N
         6GarhXDoIqyc2D/gNyDDe6U8KvEm9nLsoy4lflU+Ucsl7HoqN/GQbQD3fKfx1FQCtlNJ
         88sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAsekAdJx5xfgBpbYQDkPwiQ0YjjcLUd93G6jJA+bvgQZZJ8ypnET83yszfwxtuSLaoj5B/mckrDnMOcGkqTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Omi8jgQjToRWAOzxyoA+c9vTaQHRIIb0mY+Pejvxu2I75FtI
	55I92LqKqVQieNkDXmBamI4012u8hOH3ep3WZ1T54ylDhv+FipI1cniYogCNTQ==
X-Gm-Gg: ASbGncsQYwxU+un8bdoMy4e0BQZHrHX4YnYgIdxzHaIAyfE2M5A+KdFB0SXaL4TPbgs
	AirqaF0zVwcTYOcpFbxp9Dh02R1fCmYC9b5X5uP1TaYLdpE1u4Y2QI+X41jqyWOlR9Bs7XU6xd6
	c0AevkIg2KbxnZeqKfo2jEcx7ytZt8X24PMA2aoGF1QIBlyEpV3vZPPFmBG9ikrSdlW/Bz4sf55
	F4XefuN8dMwP7nShxZyzW1e4FGdScT5r2dlqrtRiYvJ
X-Google-Smtp-Source: AGHT+IE1MP4n6e0xT6O4u5Tlnrsd5VtUq4n8BNtkEUzNio6fpacn1x9Fa/HW6pEEO9LhGetK3e/V0g==
X-Received: by 2002:a05:620a:294f:b0:7b6:78e9:1ea2 with SMTP id af79cd13be357-7b6bcac8926mr229275785a.4.1733445905567;
        Thu, 05 Dec 2024 16:45:05 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296d4d7dsm14242021cf.34.2024.12.05.16.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:45:04 -0800 (PST)
Date: Thu, 05 Dec 2024 19:45:04 -0500
Message-ID: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241205_1904/pstg-lib:20241205_1757/pstg-pwork:20241205_1904
From: Paul Moore <paul@paul-moore.com>
To: 15074444048@163.com, audit@vger.kernel.org, eparis@redhat.com
Cc: 15074444048@163.com, lihaojie <lihaojie@kylinos.cn>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kernel/audit: reorder the member of audit_context
References: <20241205063023.744685-1-15074444048@163.com>
In-Reply-To: <20241205063023.744685-1-15074444048@163.com>

On Dec  5, 2024 15074444048@163.com wrote:
> 
> Adjust the positions of target_ref and target_comm to
> reduce their direct proximity. This can prevent the memset
> operation on target_ref from potentially affecting target_comm

I don't really see the above as very convinving, sure by moving the
target_ref field after target_comm it is less likely that a too-long
memset() on target_ref will impact target_comm, but ...

* lsm_prop is a fixed sized struct so memset()'ing it should be
easy to verify.

* if a memset(target_ref) does go long, it still jeapordizes other
parts of the audit_context struct (see the audit_tree_refs pointers).

If we need to workaround some shortcomings of the static analysis
tooling (which compiler/tool are you using?) that's okay, and the
paragraph below is fine, but I don't believe this change really offers
much in the way of runtime protection (the first paragraph).

I'm CC'ing the linux-hardening folks as they may have some additional
insight on how to best work around static analysis limitations.

> The compiler's static analysis tool considers that the memset
> operation might affect the adjacent struct member target_comm,
> potentially causing subsequent writes to target_comm to exceed
> its boundaries. Even if an overflow does not actually occur,
> the compiler may issue a warning because it cannot fully
> determine the safety of the operation.
> 
> Verification:
> - "pahole" shows no size nor member offset changes to struct audit_context.
> - "objdump -d" shows no object code changes.
> 
> Signed-off-by: lihaojie <lihaojie@kylinos.cn>
> ---
>  kernel/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 0211cb307d30..77c140228a4a 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -144,8 +144,8 @@ struct audit_context {
>  	kuid_t		    target_auid;
>  	kuid_t		    target_uid;
>  	unsigned int	    target_sessionid;
> -	struct lsm_prop	    target_ref;
>  	char		    target_comm[TASK_COMM_LEN];
> +	struct lsm_prop	    target_ref;
>  
>  	struct audit_tree_refs *trees, *first_trees;
>  	struct list_head killed_trees;
> -- 
> 2.25.1

--
paul-moore.com
