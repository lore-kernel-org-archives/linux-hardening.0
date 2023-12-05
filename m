Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xkuupgjn"
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DDA120
	for <linux-hardening@vger.kernel.org>; Mon,  4 Dec 2023 23:01:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b837d974ecso3347421b6e.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 Dec 2023 23:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701759717; x=1702364517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WHU/5DxAV5pvSXplC2cxt/UjGS3r4Zdun9PgLyN7QY=;
        b=xkuupgjne468/xDrloQG3j70wdp/YRLRTn6Lhl7XN7iec2+FtWsavNmvWimHh34NsS
         0p+1vo1JW4qv5wLLLaW9Eda3phiFM1MxucExFILcs+QnDf1N1JrZgKM16ZRnWTcJVTaw
         h1z6IQpm61yaPALqyhiaCro0HMijsK6M2JbN6Infm9u3Xd64Fg/Vb8lhIyIO4esOH6Xq
         XTSzklRMUcGOCrV0JeKShYcrGVzHQJlqCLVP2cDnXofGiWufgJJVMROGR1VAIbVbSbe3
         hRJJgk6T4likZuD9PWppoLtSsnZWrotkXJoFyINfI4+kwHZdUjGhp5DHayyAsYPuLu3n
         Uypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701759717; x=1702364517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WHU/5DxAV5pvSXplC2cxt/UjGS3r4Zdun9PgLyN7QY=;
        b=H2XNgyoTUBG5g9jD6kBPmg1nYC7dxUQmgBTM69n0vC+b7Kc58la8IJn1pF2hEWPb9F
         xqtLM11lGJ0R+zNhTi3DvtpTJQcR9mFMhklPxSeWeH+6ugS41NDPtUOcmBqc9L7u6UER
         XP2PAVCYSoxxSQB+nRFsKGZckykYHmjHK6dE3WRMHllw+SRftGPVX1G1kcRVsPnuir2o
         27OpPcmVVpOZxfG463LNv2U0EQBzY40uABK3TXqo9S6Z96bimS1y6COP3uJ6FYM8/JXS
         N7ONaAlrxnurWKST8BjjPE+UWPlKw5OyX2kftirZS4zF62aPizjLF/YclsHy6g5XZuIU
         KHRw==
X-Gm-Message-State: AOJu0YzF5+4vn1vS/9hQ5e6c+6sWkvtkFtxcRC4Cr9G5PTNXbY/ftrms
	teGd86X4gzFog4jYuRio0s20nA==
X-Google-Smtp-Source: AGHT+IFgJFUGIFJjewT8kTEELs0n4UFfcQ+u/MO6g5eqAMkbJACtIfGGkXoPdnvg0FEz3dtP8TQpZg==
X-Received: by 2002:a05:6871:4318:b0:1fb:75c:3fea with SMTP id lu24-20020a056871431800b001fb075c3feamr6891719oab.74.1701759715826;
        Mon, 04 Dec 2023 23:01:55 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id v4-20020a634644000000b0058901200bbbsm8671692pgk.40.2023.12.04.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 23:01:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rAPRJ-0044q7-0q;
	Tue, 05 Dec 2023 18:01:53 +1100
Date: Tue, 5 Dec 2023 18:01:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] pstore: inode: Convert mutex usage to guard(mutex)
Message-ID: <ZW7K4Up79Ablsoqc@dread.disaster.area>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212217.243710-2-keescook@chromium.org>

On Sat, Dec 02, 2023 at 01:22:12PM -0800, Kees Cook wrote:
> Replace open-coded mutex handling with cleanup.h guard(mutex) and
> scoped_guard(mutex, ...).
> 
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/inode.c | 76 +++++++++++++++++++----------------------------
>  1 file changed, 31 insertions(+), 45 deletions(-)

This doesn't really feel like an improvement. WE've gone from
clearly defined lock/unlock pairings to macro wrapped code that
hides scoping from the reader.

I'm going to have to to continually remind myself that this weird
looking code doesn't actually leak locks just because it returns
from a function with a lock held. That's 20 years of logic design
and pattern matching practice I'm going to have to break, and I feel
that's going to make it harder for me to maintain and review code
sanely as a result.

> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 20f3452c8196..0d89e0014b6f 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -180,25 +180,21 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	struct pstore_private *p = d_inode(dentry)->i_private;
>  	struct pstore_record *record = p->record;
> -	int rc = 0;
>  
>  	if (!record->psi->erase)
>  		return -EPERM;
>  
>  	/* Make sure we can't race while removing this file. */
> -	mutex_lock(&records_list_lock);
> -	if (!list_empty(&p->list))
> -		list_del_init(&p->list);
> -	else
> -		rc = -ENOENT;
> -	p->dentry = NULL;
> -	mutex_unlock(&records_list_lock);
> -	if (rc)
> -		return rc;
> -
> -	mutex_lock(&record->psi->read_mutex);
> -	record->psi->erase(record);
> -	mutex_unlock(&record->psi->read_mutex);
> +	scoped_guard(mutex, &records_list_lock) {
> +		if (!list_empty(&p->list))
> +			list_del_init(&p->list);
> +		else
> +			return -ENOENT;
> +		p->dentry = NULL;
> +	}
> +
> +	scoped_guard(mutex, &record->psi->read_mutex)
> +		record->psi->erase(record);

And now we combine the new-fangled shiny with a mechanical change
that lacks critical thinking about the logic of the code.  Why drop
the mutex only to have to pick it back up again when the scoping
handles the error case automatically? i.e.:

	scoped_guard(mutex, &records_list_lock) {
		if (!list_empty(&p->list))
			list_del_init(&p->list);
		else
			return -ENOENT;
		p->dentry = NULL;
		record->psi->erase(record);
	}

Not a fan of the required indenting just for critical sections;
this will be somewhat nasty when multiple locks need to be take.

> @@ -317,19 +310,19 @@ int pstore_put_backend_records(struct pstore_info *psi)
>  	if (!root)
>  		return 0;
>  
> -	mutex_lock(&records_list_lock);
> -	list_for_each_entry_safe(pos, tmp, &records_list, list) {
> -		if (pos->record->psi == psi) {
> -			list_del_init(&pos->list);
> -			rc = simple_unlink(d_inode(root), pos->dentry);
> -			if (WARN_ON(rc))
> -				break;
> -			d_drop(pos->dentry);
> -			dput(pos->dentry);
> -			pos->dentry = NULL;
> +	scoped_guard(mutex, &records_list_lock) {
> +		list_for_each_entry_safe(pos, tmp, &records_list, list) {
> +			if (pos->record->psi == psi) {
> +				list_del_init(&pos->list);
> +				rc = simple_unlink(d_inode(root), pos->dentry);
> +				if (WARN_ON(rc))
> +					break;
> +				d_drop(pos->dentry);
> +				dput(pos->dentry);
> +				pos->dentry = NULL;
> +			}
>  		}
>  	}
> -	mutex_unlock(&records_list_lock);

This doesn't even save a line of code - there's no actual scoping
needed here because there is no return from within the loop. But
with a scoped guard we have to add an extra layer of indentation.
Not a fan of that, either.

> @@ -449,9 +439,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!sb->s_root)
>  		return -ENOMEM;
>  
> -	mutex_lock(&pstore_sb_lock);
> -	pstore_sb = sb;
> -	mutex_unlock(&pstore_sb_lock);
> +	scoped_guard(mutex, &pstore_sb_lock)
> +		pstore_sb = sb;
>  
>  	pstore_get_records(0);
>  
> @@ -466,17 +455,14 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
>  
>  static void pstore_kill_sb(struct super_block *sb)
>  {
> -	mutex_lock(&pstore_sb_lock);
> +	guard(mutex)(&pstore_sb_lock);
>  	WARN_ON(pstore_sb && pstore_sb != sb);
>  
>  	kill_litter_super(sb);
>  	pstore_sb = NULL;
>  
> -	mutex_lock(&records_list_lock);
> +	guard(mutex)(&records_list_lock);
>  	INIT_LIST_HEAD(&records_list);
> -	mutex_unlock(&records_list_lock);
> -
> -	mutex_unlock(&pstore_sb_lock);
>  }

And this worries me, because guard() makes it harder to see
where locks are nested and the scope they apply to. At least with
lock/unlock pairs the scope of the critical sections and the
nestings are obvious.

So, yeah, i see that there is a bit less code with these fancy new
macros, but I don't think it's made the code is easier to read and
maintain at all.

Just my 2c worth...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
