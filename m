Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C5132C38
	for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051057; cv=none; b=BWqiHO2Ut0J15hImd5+iAJQTo5lXZ0ruMtkNAQ3kA+mZjswiXz4crC5/pqexPppxzhoFbVKW9szgiMhJemzJF97pg2YdnrLgFcTOO8HIzemi+Lno4JrhIlCATCYW9zblD/OV3ZEyn4ogVXrNcbvPjNYqRVeccU0rwzaUCcCvDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051057; c=relaxed/simple;
	bh=ACQEgjHXrHrKmVUN1e84w9K08GUoD7rvTF7AzK/2oLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMeHaGdMZ074F1jUJYTPwGabvTNAi+mno/+CPknJQE1MZmGQp2yk6LHKluH+fi7EPBK1niTNqw57A8T+eqS0nz73c814xEiOxXsO16mhE3kyUT+fhFT6mqFXOWb6oW0IO63MiS7OssFujlGbSyPdImJIRmrMsWr8JruWT5rAurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUKc5GZ0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUKc5GZ0"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512e39226efso1166400e87.0
        for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711051054; x=1711655854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck9XtKTBgRiwFDSQngG8cInr2uoxIAAWioBX8TmAnyo=;
        b=EUKc5GZ0tCVMydYn4Zjgc59pIQW6FtI3oUrKP4tTiXmoc4Wf7NYzII4ZrHP4zdeKJP
         4ztu6DX4lhWEeF9WTMioGrhUhtLIhYI/UZNeSY4V1BsqVecn881JdG71Cw1ORYnXx7Fw
         oozS2IzoiNesxe8stXlvIE93EKHi8/yS//19piK1S62M5nZQzuU3dBLCTxQSDez193lH
         zvsmtvlnqsMAjDRwaLkV/PKjSmPuGJgvGip9fV1lw+tkxMPjyqJuhViNWrureVqF/B1p
         BuGryC1FS8bW+O2zzKxHesVlgNNFZFKur3Z/HSI8JAPbbVxYnSeEPQnkMabrmvCrn+aN
         txOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051054; x=1711655854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck9XtKTBgRiwFDSQngG8cInr2uoxIAAWioBX8TmAnyo=;
        b=xVd0Xp5jMbLAL+s9XM0xT+KV2jxEauU6re2hLuxBt/Zw6PrGe+55Bz/Um+wlXIIiId
         OY3cmOShnQTdUS6iQXshPMOpqOzaNv0ouJIKYFYgZBcTYQsRaHMbplAgyMaVKkPX+0g4
         h7QKPtzPjq6TjFDRCQI6ahQljdTjeiBHpPdMXUYcgUoF3OwLi0oUBTiuiv3UUMNAPutn
         cV2T7kcnfq+XJHIZITezMI3IsS0OHLGYnucUc3+cPYod+p1MfTevfOfNn26UNBx3BLaW
         dRxWe/dlUVL80O0cTj4uvqmnJjrzfLSOirSWxnl9Ls/bezSGC3/rcrDxVCaesna2IkTm
         HoKA==
X-Forwarded-Encrypted: i=1; AJvYcCVdAta+Oao79c7U/w7laPt226gFnONJfagAgCHlV9ntWqNrE5tQ9GtQZH8wKimxpKmIEXVSLHvFGZVxWDIvQZ3oF5IbgHHZpcxE5OmtT6T1
X-Gm-Message-State: AOJu0YyDYAQ0ZnxVt8WdYaa2SdszWJmJJbhQKgqMGZlC8IXs9hxV/o6W
	U+p6i9illLeMaurM930rwvWdsUPpYKEc2a2F3d5TENS9BMRP1JMGRhriPEsll737zCDSBa5pmSt
	fBWuF0Mkm4bxEdT+Clx09mBbednzjKtaTp99p
X-Google-Smtp-Source: AGHT+IEm3LB16hV2ttktwzI7uFI9wHrobF/GyRBvFlFKy38e078SgRE+nrCXL99kg0aKWSlsYgwHdwgeQSI3HPnhMyQ=
X-Received: by 2002:a19:ca13:0:b0:513:da24:fc0b with SMTP id
 a19-20020a19ca13000000b00513da24fc0bmr247849lfg.33.1711051053968; Thu, 21 Mar
 2024 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
 <871q83eepl.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <871q83eepl.fsf@email.froward.int.ebiederm.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 21 Mar 2024 12:57:21 -0700
Message-ID: <CAFhGd8r_Z2m4akKTBvxy7s8Nwc1HLUE+uKu31mAya5QQyhBhig@mail.gmail.com>
Subject: Re: [PATCH] binfmt: replace deprecated strncpy with strscpy_pad
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 21, 2024 at 9:23=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> I am perplexed.  Why not use get_task_comm fill_psinfo like binfmt_elf
> does?
>
> It seems very silly to copy half the function without locking and then
> not copy it's locking as well.
>
> Given that the more highly tested binfmt_elf uses get_task_comm I can't
> imagine a reason why binfmt_elf_fdpic can't use it as well.

I am not sure why the original opted for strncpy over get_task_comm
but I made the replacement without being aware of the literally
identical code present in binfmt_elf.c

I'll send a v2.

>
> Eric

Thanks
Justin
