Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3014F9FF
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176504; cv=none; b=I+csomYJFouC5snku6H8NG/O7Er59Eqgzt1hxpQK3z7ygksRmouUy+1pm1qnUIa3PIGMrYkPIhDKT1g/9ZaXES/Z+RRMj+9Ej7klWRu1jtiqXxJ8au4+xrB9zpVCt/D7YkSYZhI1LqYtAHH1sVbmHrPJMHAHeAMCSRi8BZSUqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176504; c=relaxed/simple;
	bh=v7t/b1bseEGT07c3FY8utGzEJPHu0vgEf5zHyuSLnLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8gWUrmzVSYpeB1MSyxCewvMbVdiWNcyzIYAEUnZbVlvH/Fnb9JOhQoXdcW0KMbwu7HKKp+AV3bpWmkZKZp9O5MwTyqwP+qve2rhtSeqZwGaNwkFk26Q8YNsInGN79obMxapTEMkULSLNKBU7wJiYoDnXqY0e3dylV/qcRUNr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I7h1czg4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I7h1czg4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab6da1bb1a8so8688066b.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 10:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738176500; x=1738781300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8bf4DZJPP2rSwdY+pwJS8gO4tmZtY2U6WvRvjgGimU=;
        b=I7h1czg4I1GDCPTJ1oVEGTQEPJWrazAxiTxesUcdAuvFqTtYatl32WFit+ZcBto7QP
         MD/pp7jm/q/ZPHKpc5u5A5bM8roGooIJfuk3NKqWJzy00kMxj+rBRuKyCdKTk7xxeBho
         Cslq9Rj7pz1QCy7IitKCmJ45hTh/uq9QnNBbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176500; x=1738781300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8bf4DZJPP2rSwdY+pwJS8gO4tmZtY2U6WvRvjgGimU=;
        b=r4K0KIg9Tk+XUojRmV3lDpDUd/F85T/SBsdwaRGxoYhPEW6CEXIffZcDke9thTaZtK
         wlpknagaKnZYJoBRbvzuXOOA9Uxx+PztEWdO3hcSqI3OL0TPTuflao4LI137NRGyMEAS
         TYrjTb+F9hkGcjJraKljSqR5C0riCtPKyyQO/a4EpyegijDmJ4oGtKLSyIYTaxRSyTQp
         xjA1D3ossneyU4VSBTBdPFBMuiyyarn/JU5ZTgd0uq3mgn9PH9zxwNAfWfwIb1I5itGW
         xomQreWQywPSpuZ8NjIBVNOZEYAclHkDtjaXvOr1qWCbLDl957DlrrsDIyfDUJnmj4P2
         +uIw==
X-Forwarded-Encrypted: i=1; AJvYcCVql88Gk/z87ZhJ+qhc/vCLPmoPKTHu2WI2PrMDmaFMIKAXnztT6VYTWs1Jd3MD385H5Vxhre7u1byrDCbDlw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIWqZzAdJM1x59zxHiCnxqMfc2CQ6FqOa4pOehTOVQGCpFOdt
	Z1vRUNTWCtV/zYel9C+aap1moOKHL7DnN2/6bXMwvSUCme7T1K125xswBQgxeaYqtuP5bKHqLr9
	dRYA=
X-Gm-Gg: ASbGncuAxVNtXhZ60JvNkb5kbU3zcIgCyUqgxlYh5IM+yTpNQ1DyPqQ2Ap4d9iiSVMb
	WZmyZwxUy/x31afpzV+WQiTQsclFxXbuE3PTTgwQqkmKwInEQAIdH7DJQ+qjO6N7vFG/vukW/A/
	Mh/FZifpWV0TGv4DH+ZKyr2ItGoJLSBxrGPAG35i7RPlwPE9maoEqn15/5ZPwwAg9iSacwnOTuc
	R6ZxOnU5np5XllW+FSk2q/RDeelZK6VIJZdvfelLGEcVWklJdplSfljhz2XjaMay0k/WAqE79/Y
	AGCjZMDhVkAXDYfPimwKOV9/YSRKTzTwHNByRGwQA49IWFv57xCJohYFslsfLGo4OA==
X-Google-Smtp-Source: AGHT+IHpQncC6iCioHofvz/oec9rfib/vANqCkwOO+n7UoXxOLskPD8MDEOBEVM21prRXcwceOU8rg==
X-Received: by 2002:a17:907:d384:b0:aa6:85d0:1492 with SMTP id a640c23a62f3a-ab6cfe12d52mr398154866b.37.1738176500572;
        Wed, 29 Jan 2025 10:48:20 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6aa40824asm571665366b.134.2025.01.29.10.48.19
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 10:48:19 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so3854966b.2
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 10:48:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUifO8ZkRrhpsAB2tHqriqD1Cqg+YwkZL5JA/PA0R2Mz8Jn074LxF8cojdtgKvpDloWeBg1dlXcJ2kort7B+GY=@vger.kernel.org
X-Received: by 2002:a17:906:da85:b0:ab6:9d92:6d6 with SMTP id
 a640c23a62f3a-ab6cfd0d35dmr415053566b.26.1738176498692; Wed, 29 Jan 2025
 10:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
In-Reply-To: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jan 2025 10:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
X-Gm-Features: AWEUYZlqaMWdacM1L6lq7K7jLmz8nrxtrZnee6xpSEfGqjffsjadL1gFNvtIh-4
Message-ID: <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.14-rc1
To: Joel Granados <joel.granados@kernel.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, 
	Baoquan He <bhe@redhat.com>, "Bill O'Donnell" <bodonnel@redhat.com>, 
	Corey Minyard <cminyard@mvista.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 00:14, Joel Granados <joel.granados@kernel.org> wrote:
>
>   All ctl_table declared outside of functions and that remain unmodified after
>   initialization are const qualified.

Hmm. A quick grep shows

    static struct ctl_table alignment_tbl[5] = {

in arch/csky/abiv1/alignment.c that didn't get converted.

And a couple of rdma drivers (iwcm_ctl_table and ucma_ctl_table), but
maybe those weren't converted due to being in the "net" address space?

Anyway, taken as-is, I'm just noting the lacking cases.

            Linus
