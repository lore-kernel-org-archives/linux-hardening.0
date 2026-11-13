Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598033;
	b=BOzGNNPgFmsUC9Llzrt3rOERkQe1bC6gkKAT9i6ZPh8QLSdyZVmDkn8PnwESd6IKDrf9
	 k7havty3WxFICfk6g82sVoMfey0wPymhV3mOaDwPMfSC8YG1RMpDQSYGM4WnTo1Z/ha0v
	 +jYvnb/H2OD7LFJG7JNTkoRESocO+zwTbbQfXtirAd2A8EEyZ+6I4JbgumGSZExDAf6b3
	 O3PxiSLDNSITzCR3XpM1AHuZ9HJd4uqsrSlWLV0JCfCE6NO7fUoQTmV1YREgEfGkefGup
	 5sPRXK16xj+lUeSrwwKdx3C/W1dTF47jar9/G1F+XiM5Y2u4dpRAKFth5h7dKsVTwTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U3AhBwwRdHP+PSqDV2SrK9/Ks+bgbjGaOMF9elG5z9w=;
	b=KZBbYFLkzbynfUxCX+QQpvpozxN8+zAHgU0VCnYAQYxwcZA8yPmASHVsvoxNHUuyoPvt
	 Eken22IQjoE2GPhT8Ma7ZLq1SZ7NUUFWpHxNv5JEOrxquMxWTy6BOoVs3IDaqIm0buz6N
	 Ud0X2gLKEZeqvbiOZipVYDWpO8LhiJcCp/xFyulE6A0AOR5UXu0ipVY/f1smTEYPun/+6
	 rk9F45JDkpr/eEie6F8+vjUPzpS8qHola3z4DizXk9SSD3RwwvquTuhVE8y8Hn2auD7gH
	 I3sM3yzXPpXT2AQW5arCvtTcvrGj9IZvjVtidtUkhvBbDVD37Zzv3gtIfNFk2JNgwtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YtG6kPH5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9A606A338
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 19:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB9A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YtG6kPH5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so8768615e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794598031; x=1795202831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U3AhBwwRdHP+PSqDV2SrK9/Ks+bgbjGaOMF9elG5z9w=;
        b=YtG6kPH5BQ+tEA07nC4jJn9hV3XULol2U8+xA426Zy0wraJE8lqB5BHoJ6GKSziRwv
         FNhmHQ0iL2xjrP7gnRpug6wKtcUub5hLVK4Y0R2YQq4S+pNBvoCjpcwktlVGl0wphqRp
         J4/8XusCJk/iFxIP63j24wOn+qWfiTiI6EPYZuE4Kym4A97bbOS+xo8c7pUxuSKtRLdy
         AdkcrpjqTVpkR0Jum0gcnfP/s2HTu8TfbxH2LXp59tymwR4aj7oVjpvp62ShPyDyTrE6
         VPFQWC7zq1888HIyIJ+sWSR5/wLkik0QrtYvL0tJ4YlDPEuxOMgCtwWiJHq5EfEEp7fo
         RVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598031; x=1795202831;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3AhBwwRdHP+PSqDV2SrK9/Ks+bgbjGaOMF9elG5z9w=;
        b=h59OEigp9pIhJlGBZnq/phP99rj0uCaEwrj62ll30wCTM3be8hPL7P4ki8fkCPRus7
         7GyyBBYLTiC4ErNeeLL73KL9/CZ9f0FDmk7eypUjoK4c3DLVi2pqLppD3eiG0uzc9V5X
         +HDFv4xVrOALNk13N9+ejcxA6ipK4ZStd/fZAla+cDO4qvIAma3QkgAcUm08FqnRbri4
         jN0uzSSSy/wPpf8TRk/BgrxoA5pEdRany9QOFGb4sV0aJroZeB8E5aDxch56NsV19zif
         8f24Dj9baDX7NQiMH+n/zediT9iMWcrlt9OrVeEaZqPWGduu88Ogtxf7isbyPIQBM6qW
         eD5w==
X-Forwarded-Encrypted: i=1; AL+hErECZWxjk52AFkZ4srZL0xSziS2+7nl8WemlZ4XPZcWsR5uMnlpnANvHmegbu+LX4PHLMSkZjurkRpAM5ZzIuCY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IY2hisy9T6AybJUpuwKQBDU7T2zVT6yaTol4zx7WQEvd43DEa
	uUTFYz/uEpi20CRASlQ+y5b9+OUaKZLqyz8fjrUoXlVnH52qGMrfOde3
X-Gm-Gg: AYBFou04NC2q8VyYyKgnyaqxs9R9ca0oEnUsvfPyOvNWeeml27GccAHv4v2/DwBvAUD
	DhyQe70gk0G2qYtUiTvH/xujJGzXYlWfbQqRB8HJ373dHqloQwmLRx5b/4V9hTRqTL1PjYrs6Ow
	JwdZQs7ACaggk7z/3g/mOcR4RokpADgD5OxgFD82plrWgaer9VKAmDSQGKm+jggwy8QxRu3jVOv
	Z6SbsLWb4HWlwNt669u+/3H/VbENx7DIDxgxp+Dk0jFuhsAtlf0CFdiRgjlpXZR86wFQ/8Ho9NR
	Vr/bp6vG7qE+PqVbWGLGHsxlxakDvIwCmFgKuueMeXpIW3crkjyC5TwObOeY3uzV1fb45GAZKaM
	BWb2NKEbihcs5chz7o7HJDyCqq5fqCIxsXKMi+UHfBQf8Fl4l6SSVDjpZjC+ZHtLIttZ+GvT49A
	Unp87rKw6wtROO9Rolqf8B6oKJrtxQ6sHaeJBSEtBHSpi5Sp+7JKLo/ZK8QDffEuTKYVJUVwZov
	GrEG/H26GIVp9tgy0SIZs7EK+MmaiOBSkUXwxIVEM+SFSiU3+O27T1XzQfcANLRF6YJIKAnpWBv
	ehq+7/qtd64frHBi/XEdLsaIGSH2VNZ2qG3QJ3h3EfLY/qArql6LALGFx/WroZHabQ==
X-Received: by 2002:a05:600c:5491:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4bb55ac6ca0mr79115875e9.33.1794598031047;
        Fri, 13 Nov 2026 11:27:11 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55afb6absm89576315e9.15.2026.11.13.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:27:10 -0800 (PST)
Date: Fri, 13 Nov 2026 19:27:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, mkp@kernel.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, morbo@google.com, justinstitt@google.com,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: iscsi: Replace strlcat() with snprintf()
Message-ID: <20261113192709.1c384c98@pumpkin>
In-Reply-To: <202611120959.62EE8ECF@keescook>
References: <20261110093137.37744-1-nikitash.mariiaw@gmail.com>
	<202611120959.62EE8ECF@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 10:22:07 -0800
Kees Cook <kees@kernel.org> wrote:

> On Tue, Nov 10, 2026 at 01:31:37AM -0800, Mariia Nikitash wrote:
> > In preparation for removing the deprecated strlcat() API[1], replace
> > the strlcat() call with snprintf() to construct the AuthMethod value
> > directly from param->value.
> > 
> > Since buf1 contains unmodified copy of param->value, formatting
> > original value and suffix together preserves the NUL-terminated
> > output, including partial or omitted ",None" suffixes when the
> > 256-byte buffer is too small.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > ---
> >  drivers/target/iscsi/iscsi_target_tpg.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
> > index 99772364c88e..aad82a37538f 100644
> > --- a/drivers/target/iscsi/iscsi_target_tpg.c
> > +++ b/drivers/target/iscsi/iscsi_target_tpg.c
> > @@ -624,7 +624,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group *tpg, u32 authentication)  
> 
> OMG this whole function makes me weep.

The rest of the file isn't much better.
I'm pretty sure all the:
	spin_lock(&tpg->tpg_state_lock);
	tpg->tpg_state	= TPG_STATE_INACTIVE;
	spin_unlock(&tpg->tpg_state_lock);
sequences aren't doing what the writer expected.

> Also, I think it has an out of bounds write in it too:
> 
>   echo None > .../tpgt_1/param/AuthMethod
>   echo 1    > .../tpgt_1/attrib/authentication
> 
> and I don't think it handles the truncation case. This is a good candidate
> for a full seq_buf rewrite, IMO.

Not really, it just needs rewriting to avoid all the string copies.
Some are just silly, eg:
				len = sprintf(buf2, "%s", buf1);
				none += 5;
				sprintf(buf2 + len, "%s", none);

> 
> >  		none = strstr(buf1, NONE);
> >  		if (none)
> >  			goto out;
> > -		strlcat(buf1, "," NONE, sizeof(buf1));
> > +		snprintf(buf1, sizeof(buf1), "%s," NONE, param->value);

I'm not sure, but I think it could look for the "None" in param->value
rather than its truncated copy.
If the strings start getting truncated I'm not at all sure anything
sensible happens.
Then there is this line:
	if (!strncmp(none + 4, ",", 1)) {

> >  		if (iscsi_update_param_value(param, buf1) < 0)
> >  			return -EINVAL;
> >  	}  
> 
> And doesn't need memset either. e.g.:

Oh, I bet it does.
There is a random 'none + 5' that needs to hit a 0 byte.

> 
> diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
> index 38d2238dfe08..da720f6be5c1 100644
> --- a/drivers/target/iscsi/iscsi_target_parameters.h
> +++ b/drivers/target/iscsi/iscsi_target_parameters.h
> @@ -41,7 +41,7 @@ extern int iscsi_change_param_value(char *, struct iscsi_param_list *, int);
>  extern void iscsi_release_param_list(struct iscsi_param_list *);
>  extern struct iscsi_param *iscsi_find_param_from_key(char *, struct iscsi_param_list *);
>  extern int iscsi_extract_key_value(char *, char **, char **);
> -extern int iscsi_update_param_value(struct iscsi_param *, char *);
> +extern int iscsi_update_param_value(struct iscsi_param *, const char *);
>  extern int iscsi_decode_text_input(u8, u8, char *, u32, struct iscsit_conn *);
>  extern int iscsi_encode_text_output(u8, u8, char *, u32 *, u32,
>  			struct iscsi_param_list *, bool);
> diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
> index 2b318b13268e..34846f5b641c 100644
> --- a/drivers/target/iscsi/iscsi_target_parameters.c
> +++ b/drivers/target/iscsi/iscsi_target_parameters.c
> @@ -642,7 +642,7 @@ int iscsi_extract_key_value(char *textbuf, char **key, char **value)
>  	return 0;
>  }
>  
> -int iscsi_update_param_value(struct iscsi_param *param, char *value)
> +int iscsi_update_param_value(struct iscsi_param *param, const char *value)
>  {
>  	kfree(param->value);
>  
> diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
> index 99772364c88e..6d2cdfa89be5 100644
> --- a/drivers/target/iscsi/iscsi_target_tpg.c
> +++ b/drivers/target/iscsi/iscsi_target_tpg.c
> @@ -8,6 +8,7 @@
>   *
>   ******************************************************************************/
>  
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <target/target_core_base.h>
>  #include <target/target_core_fabric.h>
> @@ -579,8 +580,9 @@ int iscsit_tpg_del_network_portal(
>  
>  int iscsit_ta_authentication(struct iscsi_portal_group *tpg, u32 authentication)
>  {
> -	unsigned char buf1[256], buf2[256], *none = NULL;
> -	int len;
> +	DECLARE_SEQ_BUF(s, 256);
> +	char old[256], *p = old, *tok;
> +	const char *str;
>  	struct iscsi_param *param;
>  	struct iscsi_tpg_attrib *a = &tpg->tpg_attrib;
>  
> @@ -590,44 +592,33 @@ int iscsit_ta_authentication(struct iscsi_portal_group *tpg, u32 authentication)
>  		return -EINVAL;
>  	}
>  
> -	memset(buf1, 0, sizeof(buf1));
> -	memset(buf2, 0, sizeof(buf2));
> -
>  	param = iscsi_find_param_from_key(AUTHMETHOD, tpg->param_list);
>  	if (!param)
>  		return -EINVAL;
>  
>  	if (authentication) {
> -		snprintf(buf1, sizeof(buf1), "%s", param->value);
> -		none = strstr(buf1, NONE);
> -		if (!none)
> -			goto out;
> -		if (!strncmp(none + 4, ",", 1)) {
> -			if (!strcmp(buf1, none))
> -				sprintf(buf2, "%s", none+5);
> -			else {
> -				none--;
> -				*none = '\0';
> -				len = sprintf(buf2, "%s", buf1);
> -				none += 5;
> -				sprintf(buf2 + len, "%s", none);
> -			}
> -		} else {
> -			none--;
> -			*none = '\0';
> -			sprintf(buf2, "%s", buf1);
> -		}
> -		if (iscsi_update_param_value(param, buf2) < 0)
> +		/* Remove "None" from the list, unless it is the only entry. */

I don't think that is what it is doing.
I think it is just trying to remove "None" and any associated ',' separators.
So:
	"None" => ""
	"Foo,None" => "Foo"
	"None,Bar" => "Bar"
	"Foo,None,Bar" => "Foo,Bar"

So you just want (ignoring the fact the "None" might be in the middle of something):

		none = strstr(param->value, NONE);
		if (!none)
			goto out;
		if (none == param->value)
			buf = kstrdup(none[4] ? none + 5 : "");
		else
			buf = kasprint("%.*s%s", (int)(none - param->value - 1),
				param->value, none + 4);
		if (!buf)
			return -EINVAL;
		free(param->value);
		param->value - buf;

Or even, if none[4] is 0, just splat a 0 into the existing buffer.

David

> +		if (strscpy(old, param->value) < 0)
>  			return -EINVAL;
> +		while ((tok = strsep(&p, ","))) {
> +			if (!strcmp(tok, NONE))
> +				continue;
> +			if (seq_buf_used(&s))
> +				seq_buf_putc(&s, ',');
> +			seq_buf_puts(&s, tok);
> +		}
> +		if (!seq_buf_used(&s))
> +			goto out;
>  	} else {
> -		snprintf(buf1, sizeof(buf1), "%s", param->value);
> -		none = strstr(buf1, NONE);
> -		if (none)
> +		if (strstr(param->value, NONE))
>  			goto out;
> -		strlcat(buf1, "," NONE, sizeof(buf1));
> -		if (iscsi_update_param_value(param, buf1) < 0)
> -			return -EINVAL;
> +		seq_buf_printf(&s, "%s,%s", param->value, NONE);
>  	}
> +	if (seq_buf_has_overflowed(&s))
> +		return -EINVAL;
> +	str = seq_buf_str(&s);
> +	if (strcmp(str, param->value) && iscsi_update_param_value(param, str) < 0)
> +		return -EINVAL;
>  
>  out:
>  	a->authentication = authentication;
> 

