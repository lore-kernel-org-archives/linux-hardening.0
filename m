Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6533CEA2
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147185; cv=none; b=D+fwYg/Ssi8QIeQUIffXFPG9v10sG3V3CpqsSgp9BPa22JJbafHQRQ98344kS1sj3WyDweItcQTvQC8rBoIQYlLnWGCKdIa2UOZ6zMvH3I0qq+0lzZyDRIVigsba1j/QDApzIOAAbI+FNJuySif2Atkvafx14NaMGZe9u53zrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147185; c=relaxed/simple;
	bh=84imE7TlZylZzQvQJKF2+t8YmJ5WhG8hl3Du3QQIs0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpUFhtd3JwJLVQxy+HGPMiW3SXXEdAbwBrw02rUFZfpyRNjbbkzJrNM2Kk21DonADTNUIftcJSF26BccEZa9mZSjnL2yQHYEzH9TZB2pySxce/MVsT+xY6dmMw81U8x51dOAtpCQMh7FWSjUfb9mpuFzbTEVs+CvhZa98YJJe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlW05DkE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlW05DkE"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so37999095e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782147183; x=1782751983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiQBDDZL1fhWnjekM23oihkaGRA+cvxb1E2FW0Sx5Do=;
        b=WlW05DkE2eAaLsPrgdwqgpzWHMisDaMpqkuC4fzZdquyb8CQTYu/6yHrmpn0hKnQsD
         NZgjJdyE2/g95viDe6Qdku4chw3G0ucK9KJVifSAxqIEkyCRHiLg2vaRjTq+eBmoyjhw
         4vT1dgzSklRuoYb1+HB5Na1HKqrhpxU/4rcX64N9um5pBER68uM9sgtsHMscT7i8InzP
         AyZVfGMT7dBYE9KMv8uAn8UyPmeUr1pHOpUo/pKLcnu5NYHGp9Pv+mEmx7/kh1v9efYQ
         w2K2eFsxn2I+GBln9kSZ7cu5TLhvng+s2vHbYhViwVKhSG+4wlnaZTU55Tc4aBDA0fvC
         LW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147183; x=1782751983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiQBDDZL1fhWnjekM23oihkaGRA+cvxb1E2FW0Sx5Do=;
        b=HeP/mQvvsDTBk9zpMHuplT+ugqigu9JSSRqKIGmRvnRghDWv9nPbL8+xNh7UNmIn9l
         4SMMKbByuRzE4aLV8xOyd5dqWQ2zI+cgv9LRBEZVSAmcxmFWnw8lQDvpM9PT4zcsdz6K
         oMer94VoA6h6m8Z2o8hoIQIN0VWal7QvkoH3SqLi8NSUt4TTwTwglCSrleTmu99516m7
         MnofQeGVAGLNBP9oOdKe5SVPMEQ/09wgDtLiKDPgavsBZIiEp9BEWI5lp/a/GLPHBqCf
         xjYK3hleyML/AuAZygxjdooACpxPhfBi115CX07MQffgtx5eqEW269L5xP6XAkMAIos2
         /huA==
X-Forwarded-Encrypted: i=1; AFNElJ9UdwQuUI9z0sOn1B185fsr2DFeaIBRnllU7RwA0flXD3ax9VrNBvMq67LTMqqgyA/HEK8b38A+cgJiXcYbgVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMI7RVPejxZBDORNWSRoLSQe+QMJ+lw6ttUOyrkbJ+Q7L5+nDO
	ZW/+DXFEZzrsSzMFkKLBFkaNJV1e0UOvW+ML97QZCWIyQw9JzpQjFIkU
X-Gm-Gg: AfdE7ck5aUjdku+vEd7UrQLCYrydNTnWu5+MygdNjqmHJpwGIvlgksWzKL2ZP2QgYYr
	xsTc1A6I2uB0XDaTRAZe+7IKgDM7V6rGdAl+A+q/sg/oENg3Rgbpexs4Z6hKEZSqFjYbXD2yVqs
	17SgPajmQZlBngCtRkW4oZ3fL50WTeO5g0d+bl4lVykqu1L0R4lXMa1l8h+E+fpvr6RB4sgSDGo
	8aB07VopPbG5jvndtuo2tmIbcFa89Ck205eP4BnB4Y0ike6d5YeXuvtIg4wa5sKxSdmU9g38IZp
	v9YlIESaWD8DiVcGEFtpUgDX5G60Y3Pi3M2rzPSSctxZ/lHsRSK6+eFI9kQd9jSwCq4EhXoL+hG
	/Ig7tWAwVorfIrwE8U1NIp7dah28KsOXxlqiyTuRUjCGQIkP6F0qBaqx29y5uP6w52NGY0txYkJ
	Q2lMMg9EH9dwLRsS1ppnUAbrgFValKtKqq6xEs+LsUDHAPwl2cgjTiTiMm1rSZ
X-Received: by 2002:a05:600c:1d29:b0:492:3fc4:bd6b with SMTP id 5b1f17b1804b1-49242314120mr234540825e9.7.1782147182587;
        Mon, 22 Jun 2026 09:53:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm27693147f8f.23.2026.06.22.09.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:53:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:53:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Message-ID: <20260622175301.6a36756b@pumpkin>
In-Reply-To: <ajlN94VO7BYNUTAy@dev>
References: <ajlN94VO7BYNUTAy@dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 10:00:07 -0500
Ian Bridges <icb@fastmail.org> wrote:

> In preparation for removing the deprecated strlcat() API[1], replace the
> strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> seq_buf, which tracks the write position and remaining space internally.
> 
> The seven open-coded WARN_ON(rc >= buf_len) truncation checks become a
> single seq_buf_has_overflowed() check after the string is built. The
> kzalloc() and its exact-size computation are unchanged, so the
> measurement string passed to IMA is unchanged.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
>  security/selinux/ima.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index aa34da9b0aeb..3d81093d16aa 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/vmalloc.h>
>  #include <linux/ima.h>
> +#include <linux/seq_buf.h>
>  #include "security.h"
>  #include "ima.h"
>  
> @@ -21,8 +22,9 @@
>  static char *selinux_ima_collect_state(void)
>  {
>  	const char *on = "=1;", *off = "=0;";
> +	struct seq_buf s;
>  	char *buf;
> -	int buf_len, len, i, rc;
> +	int buf_len, len, i;
>  
>  	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
>  
> @@ -34,33 +36,24 @@ static char *selinux_ima_collect_state(void)
>  	if (!buf)
>  		return NULL;
>  
> -	rc = strscpy(buf, "initialized", buf_len);
> -	WARN_ON(rc < 0);
> +	seq_buf_init(&s, buf, buf_len);

That is silly, you need the length of the buffer not the length of a string
that is the expected length of the output.

>  
> -	rc = strlcat(buf, selinux_initialized() ? on : off, buf_len);
> -	WARN_ON(rc >= buf_len);
> +	seq_buf_puts(&s, "initialized");
> +	seq_buf_puts(&s, selinux_initialized() ? on : off);
>  
> -	rc = strlcat(buf, "enforcing", buf_len);
> -	WARN_ON(rc >= buf_len);
> +	seq_buf_puts(&s, "enforcing");
> +	seq_buf_puts(&s, enforcing_enabled() ? on : off);
>  
> -	rc = strlcat(buf, enforcing_enabled() ? on : off, buf_len);
> -	WARN_ON(rc >= buf_len);
> -
> -	rc = strlcat(buf, "checkreqprot", buf_len);
> -	WARN_ON(rc >= buf_len);
> -
> -	rc = strlcat(buf, checkreqprot_get() ? on : off, buf_len);
> -	WARN_ON(rc >= buf_len);
> +	seq_buf_puts(&s, "checkreqprot");
> +	seq_buf_puts(&s, checkreqprot_get() ? on : off);

That lot would be easier to read as a seq_printf() - with %d and
kill 'on' and 'off'.
Why does 'security' code so often look like c**p.

	David

>  
>  	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
> -		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
> -		WARN_ON(rc >= buf_len);
> -
> -		rc = strlcat(buf, selinux_state.policycap[i] ? on : off,
> -			buf_len);
> -		WARN_ON(rc >= buf_len);
> +		seq_buf_puts(&s, selinux_policycap_names[i]);
> +		seq_buf_puts(&s, selinux_state.policycap[i] ? on : off);
>  	}
>  
> +	WARN_ON(seq_buf_has_overflowed(&s));
> +
>  	return buf;
>  }
>  

