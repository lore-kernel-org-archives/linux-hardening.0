Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C42288C3;
	Wed,  5 Feb 2025 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758393; cv=none; b=LPH0GjCE3CLOsfY/ouasS6tUNdey+5SL46Z4lsICnbgTvojKgN1mJuXnvkKgaihEpvwWSQezGYUcRO2TTkkmKTPWNnuG88FAN1qJ/bfjwPyyJ3iRPzeAgSV1llQVw2BEDrKyawlJPJ8hoKtyzHDWbr6JkwDO3QPOg57k9OTKMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758393; c=relaxed/simple;
	bh=PqFzbWTGgd5L0Se3X2D+ewZzMsZZRBkaejmCFJ6jVG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwYVGWt5MWPYTzSa2AGO6BMjXhJdb+JlcGID8U+/ZLDqa+GLFBWpLQvQjZHL7+mP1P/0SNegGNcYFXEK5OP1Fi46PZwSbcol4ffcpmbb9xNEgc5buI5WOr+DaAlvDlhjEfw8nyH7d3IUqD2Yp2DWd292DC7Qy6cChsioVhV/3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejY8gblR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejY8gblR"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so12080897a12.0;
        Wed, 05 Feb 2025 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738758390; x=1739363190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfNjTq55fsnw6SzCIB+YM+K27WJ5Up01sg+3YgXdq6M=;
        b=ejY8gblR7KNqwPiM31fn2UqtgffFYTTg7PPeMwoZIOOdhIJlMruyNFu+BO0I4JQxWE
         9jzvGhMqdL3URU0tyFj8FMh1VtYfcAuZua99ZBLeuu4V8v8uSs9cGJ7FrwUDWvXtUH01
         qgOJV2RVPlwyNYFBaB5oYeggELLXwgRYB++iVZLUm+EeM9dPEJbXPIMuLWU48xd+oQv1
         PeEu02dp1Zw/xEXpr/OlCgFkVsbqZLSAyeYSfvTh3O3IA09R8tDf3/vRddxTe3MZ+UY6
         bPHvk/pSTRDJIhN593EQ3AbkxwcOS0tfiQFi8NP4xc9TeGFD5T5oYiGItsh91BbMSG7T
         dYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738758390; x=1739363190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfNjTq55fsnw6SzCIB+YM+K27WJ5Up01sg+3YgXdq6M=;
        b=tK26kFuwLC7oQNUPsxhMDnBIqnhx854dDVGCbWpgITQU7noIrz+YX5NqQhGTqzKw3r
         joOkLBkjUg8WOMUZntKC+tpMbB9RijrDh+3Mf0S4FlrUgGXhleJPyDeryj9LMJzCnTXc
         8X/ZhV4N0m+j4TgscvO0+b1XcGiA09tVu58V/DflkstT380i95U8bxOy4Pb15UqlAiW7
         Cvmit+xpQHpUzwecRfIUlV8TKtKmnRU8ev2VQE8ylt7Dqlinfi+QVnTh9dlQLE1iBZXd
         FFwRE2ikIesdDwlt2BmLMn9XFvaOpLAAl8M1x5aCmrrXA4ftJ+xj7kIn16G6CLyViYRl
         y7vA==
X-Forwarded-Encrypted: i=1; AJvYcCU0vAprVSinmIZ82QRKaEIWFvLUmhPWN09OLwvd4Mntg3eEGafg2yKYZeEtkfnPgopugFtmhKV3eHQCFrcb@vger.kernel.org, AJvYcCUabyo0c/HSJfIuO593qfRa0jziqDRgCRME3e5tPR7SQzKyYDGrNLrE6D2xh5qgXsfkI/WJMc1zevR82JeXzE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjURzlCQUzLT0WI1xioVezJ/mEP9dPMc3gO1UKczW2vzr+a3xn
	G5mfwLyCxNn0TLM7CgZ8vCKoYkz8gyAL4X6IBhMTPTzQ6l9ZsXin
X-Gm-Gg: ASbGncvzzF7tOlq4fd/F5EMQPhZJcZo+ozo+tPKi2GiBvwmHwEcs2F/FbQ9IMSUJXYw
	9Uw+pe6KYNblNKIB1/Hf1T1DExfGgMRtjBNaeaLxZR3KNrD8OFR1QTIUepLHUX8y+nKlQQ5enkl
	VSvm3/R9aMV+LGGZFbl3m39UHKHEUGr6mBVhgbZw+tLuCVQsfGFL2micuaQHIoWZ1oMPWdzzQ50
	d05rxPcZVihJ4BNYSm1EcvcuceB22DpLCPyyv8k+qB93k5UBYu3WZCjoQQtnZDv9Fbw6w2e0AQd
	r1Jn/7/yVnxOsG5yYRwJMQ2+tCcK
X-Google-Smtp-Source: AGHT+IEm5IUWeYpZI0DEqaYXclltUvvUlq9Yatit08o6HaY+VbAx6auM5q2J1jw428G0gXDxJ7yhvA==
X-Received: by 2002:a05:6402:278b:b0:5dc:d0be:c348 with SMTP id 4fb4d7f45d1cf-5dcdb77825fmr2802800a12.20.1738758389797;
        Wed, 05 Feb 2025 04:26:29 -0800 (PST)
Received: from f (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcdb6d16edsm1336465a12.3.2025.02.05.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:26:29 -0800 (PST)
Date: Wed, 5 Feb 2025 13:26:18 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	kees@kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <zv5u3q3m7t5yehblaqnrcz2k73yozpx7nn5mvbkedrzw2jaowf@soiirioxlfbz>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>

On Tue, Feb 04, 2025 at 01:46:28AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1258aeb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
> dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15825724580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1658aeb0580000
> 

#syz test  upstream  master

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..30cff983e601 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5010,7 +5010,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			nd_terminate_link(ei->i_data, inode->i_size,
 				sizeof(ei->i_data) - 1);
 			inode_set_cached_link(inode, (char *)ei->i_data,
-					      inode->i_size);
+					      strlen((char *)ei->i_data));
 		} else {
 			inode->i_op = &ext4_symlink_inode_operations;
 		}
