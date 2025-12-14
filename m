Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADF238C3B
	for <linux-hardening@vger.kernel.org>; Sun, 14 Dec 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765720567; cv=none; b=oJqn+qP2OuKz9i895DNptjtrCYqqNt7uSEG8lsSDQyjCjidsykg0DFZQqW1f+ipoCw07bxvFVGtVYaoeIVlu9puzMjjjrHig01Y8xacXVNLLZnpM184OiuvBKTQKSd+fg/5H6zI/Xle7MABqOH5qQp6x8R9IJ+YcHSktMPbpr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765720567; c=relaxed/simple;
	bh=wedzmxq9vRGeFWym+k/7YqocDl1APLkqXKwn22ekS7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJJlUHsqkLrL5Myhg7Ht39hH7gAYLJPezm8b7QryUPdBLfQTjT/B9tiXLTRugNG+h4Ba2rObV3SB1OiXmenvZFlnvVd/MZEuHqJX8/FJcxvWcz4P3AjczmmzbHSFWa6TexqiKVcg5lrqK05x0N4GnqPAqsGdFY6wdW4r559oDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K8OXyZAn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K8OXyZAn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477985aea2bso2431445e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 14 Dec 2025 05:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765720564; x=1766325364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/kWZtfqmu/7DDkSydk2IW7goxHu5lFJdCvOdUo1JPQ=;
        b=K8OXyZAn9QmFAPwWapm7wE0P56PgzzjBWzROvwvwT1zecmtxX2GZxV2LEMd1lcoMAX
         gFSM4BHMkZ4hKhn6dDdYwy5MUHuoi3jKrijIVKxZfaEI48V4mSbalP5Ks1S3vs3PWFWO
         u9Eg5Auc2l3LZsQTvSt6MMu78Fw2AHokQecCC60hdJZtZfXfZFTa5iZYboADFEllgfMO
         sL1WfDS1MWXirtwDOBj5hqYbmWbo+9LIvEsY8W3Swom5q060XdxaoqQ05ipDvRHHW/ou
         pOQHP3h84w/j3EZsfVBbfhY/k0JABJfAKWxeNHIw/zZmptspcW2KMAcNMcnPVIEUpdkh
         oiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765720564; x=1766325364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/kWZtfqmu/7DDkSydk2IW7goxHu5lFJdCvOdUo1JPQ=;
        b=ZLWRpIM+t487WW9sxqjsJRVEGtiX682TVWLit1qWht8uavZQYIDLVWClTGQTwfG21X
         btL8HZWXCPa/6ZqvSZKmAS2sNy0FW24KnJ30tlnV67CILIgEa6XVb3lcAiZeUk/eAbNl
         rqx58TlJMBiy2dWB4JgtkVfrk8hyGsvqS/ji6rgYfren9dWbBb4wff/lY/HzUK998cE9
         l7FwLXdxmQAdyJOPQb9Xpxx0S1QGj6NK/K8yIZAH3TBJcW+rMoTDS3a1tDJRdCwwtlbw
         J2arrlGu3kn5738h6qWQJN4y67BY1PyIJtHlNThylJs8WE3JJGRsqdWWRxqAYhxr2D4L
         B9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVRTA5qBgPneE54xEjdv97bOxR2WnuJDRygWdeDxUi6MQzvfoAUOKvDdV10ji7MclUcOG33ZplkdXk+Rpv1XbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fbzvvjq+cad0F7b1zQ2pXB+J58H81ONU1QQmY8m47g3vTdTM
	EWZbFpuLXsbZ7EbEbj8V3ZksGuOSsgbXYayVF9EWY1EFBnRURT8VHo8us1eHuSNx0mSJs7FwqIb
	J+zn4
X-Gm-Gg: AY/fxX4zHvl8n8XAI1We2wS6F/NihN+X2VWJsf5u6GcTvm/CH7UWZynezJ3qEks9HD9
	qCuVS0P/ELLYWw6grDpP0aiJHIRsM5am0TKADiNCH/zB/G2Ci/Cwi02t6rWgRJOEgu8+5ujSn/l
	zQQQ2lpwSGx7i810NuwATOLdglX5lnx2zmC7MU55HlFKWdJ9xlLoZwc+1yjgEfa/3MR62RXWP3u
	uW9AA0wxwX245/GlomET4Ye/c4RWJodF4cltaOry0PPruBexMedCwuJdMgn7f/3kQdAbSvc8veb
	gud4ryjeKrdvpbsIghdg08e0ocJ1dSxmhCgJPfhH6p4ES3Mfa1sD9qzOOr/wqz3X9XCNkJM4Pfk
	4qCA5Hxd/GxHmGIJyH137EAimivgKbYzoSqaut5OCHCkZRTTqvYH6S1bL+vsKz+0UU7Gcv5U71K
	B4YfNvAjSdpA==
X-Google-Smtp-Source: AGHT+IHb0o55kPmmOQd3U8MiGG9aDz6cvWX0+o6U7s8P6ghMHurFFp1rm9FJu/Ywa84TrLMV6XYv0Q==
X-Received: by 2002:a05:600c:1992:b0:477:c5a9:33ce with SMTP id 5b1f17b1804b1-47a8f904696mr49928085e9.4.1765720563988;
        Sun, 14 Dec 2025 05:56:03 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea0169dfsm106820745ad.51.2025.12.14.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 05:56:03 -0800 (PST)
Date: Sun, 14 Dec 2025 21:56:00 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Mark Fasheh <mark@fasheh.com>, 
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, joseph.qi@linux.alibaba.com, dmantipov@yandex.ru
Cc: Joel Becker <jlbec@evilplan.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	syzbot+cf96bc82a588a27346a8@syzkaller.appspotmail.com
Subject: Re: [PATCH] ocfs2: fix xattr array out-of-bounds in
 ocfs2_xa_remove_entry()
Message-ID: <v5k5n2txkjo2hngffk44aa3noqdwt2mnpy6fueoc24jhng55y3@ms44337i4j3q>
References: <20251212190631.210139-1-swarajgaikwad1925@gmail.com>
 <CAGe7X7nY5iFFNmV5VT5Mji-vknFgi-cGeJYn6U7z5HcnCr=mBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGe7X7nY5iFFNmV5VT5Mji-vknFgi-cGeJYn6U7z5HcnCr=mBA@mail.gmail.com>

On Fri, Dec 12, 2025 at 03:18:06PM -0800, Mark Fasheh wrote:
> On Fri, Dec 12, 2025 at 5:36 AM Swaraj Gaikwad
> <swarajgaikwad1925@gmail.com> wrote:
> >
> > Syzkaller reported an out-of-bounds access in ocfs2_xa_remove_entry(),
> > triggered when removing an xattr entry.
> >
> > The root cause is that the original code decrements xh_count in-place using
> > le16_add_cpu() before reading the updated count value into a local variable.
> > However, due to the way the entry removal logic interacts with the array bounds
> > checking (enforced by __counted_by(xh_count)), the stale count during subsequent
> > operations leads to the out-of-bounds access during the removal process.
> > This patch fixes the issue by reading the current count first, computing the
> > decremented value locally, and then explicitly writing the updated count back to
> > xh_count at the end of the function. This ensures the array bounds are correctly
> > reflected throughout the entry removal without relying on in-place modification
> > timing.
> >
> > The fix has been tested by reproducing the syzkaller crash report, which no longer
> > triggers after applying the patch.
> >
> > Reported-by: syzbot+cf96bc82a588a27346a8@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com./bug?extid=cf96bc82a588a27346a8
> > Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> 
> Reviewed-by: Mark Fasheh <mark@fasheh.com>
> 

Hi Swaraj and Mark

Dmitry Antipov has sent a patch to fix this issue, and the patch status has
been reviewed.

ref: https://lore.kernel.org/ocfs2-devel/5561c14a-9aaa-43b7-95f9-8428a2364f09@linux.alibaba.com/T/#u

Thanks,
Heming
