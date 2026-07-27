Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02517082D
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785111057; cv=none; b=fBKLvOrATXXemFUqNPXZI7xrYigEZ6GcoLwZV6jDf73CT+c/otdCZ7FNAyWKMFcjoxhpco3Eu+tu465/TJ3TuSpSQrrJRm5LzHNzaeG+6Iqttw/GcnAEILWJ8uA3HcoWdH9TrMZ56XzsDKW8iVzejmRLm8hb3zZDYk/Egg1CpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785111057; c=relaxed/simple;
	bh=RM71rEpMshNU/1M43+xs6op/v06TdqK/Y4+1CcbduMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYVY+kK2Uu4cOSiiIauarabr9LImhZN2d1q2FN248rQHOirrYcBYjw6Gte9tqyI/Dc6ZYBmvEZJ28sLnRqLAT9uzsvdEik/YklG/LAUBG5pVMIkfA2QkYAJDr1kjd/zBXwqkecGW2dWJbkp901iaGlgDwqUsGNNVe9J9cn9sMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTxdw02U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTxdw02U"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso14098415e9.0
        for <linux-hardening@vger.kernel.org>; Sun, 26 Jul 2026 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785111054; x=1785715854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=01dl0IIZWjJRbfIXfFu72Txfn4OJSXE2utImaot0HF4=;
        b=XTxdw02UmK1nJ5yG6sKLznfb3GIokzTfEvCNcbSom8FkSnb1TJn3MA5FStbh77GLPz
         RUsUgPbnEMxVyhiign2UMBQmwXX6xLTnzftOukAInJ/c3cIDnDAzuAJoKUJI3AQOhXtK
         GOvuQ3O389c+I2EFsMTZ10fBCX2yJ42B2qd9bp3YWdHkuKuojqUNS1htJFj+B1+CMPA0
         jX5wsV1B8f5lIZAUXdXSsiyZCYuab0kbi4Ye2bGcJNkTFqCJIr6Q90TBo6/e7S3jIiSO
         DR8Z232XkQjZf0cssiiGXmajtaIEg917dX7A9/zrpdMnvqGTy6E5GLI/0Y0kb3rhusVL
         +/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785111054; x=1785715854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=01dl0IIZWjJRbfIXfFu72Txfn4OJSXE2utImaot0HF4=;
        b=ZioPIPEoQMY19KOgUBsA4oH0gb9D2jN0jogLiql756d3e3IBYMav1KAkTiCkqN38je
         jlnrdHjSsNRGb9PaqHy/dY3+BUWmHe8EwWNtQgH7/cxmJhMUjYaxNqGN6tzW2+xB/Cqu
         hm8m6KpCoeYm6P0PtMt4xr+ZE4zXTMGOLWI1C479qXVNB+ozhc7PEi6iFpq9DqN+y0uy
         dF5waPPWMwQwGhueLm6c5rLFwM64RLDZaHbGHAgV84A1Bq/iF6SUuEaHc+zie/3xFUSM
         Q6qJjs3NwTFnGksfWcXqUQj074NLUeucBBaBuB4UfF3kMB21DDT5ZtbFtrNx6bjEdfPN
         uOLw==
X-Forwarded-Encrypted: i=1; AHgh+RoJ/q9iR3SanP+4JgfoUsuJxQGn9VE9xrwqayjEKvfYNDE7CGyI+EP0avG++7ihZiIKftMMhIIwaXIMkn+zZ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojwAl13Ojd7RfIJZWw4ZgMf3fx2hOkC+/7mgv5VeOSTqdpAq9
	XXsNmLkNOiifr/lJIdAobAnC8ojF3Io2X2kKrUAJH1EL7YyD9nGTqB6Y
X-Gm-Gg: AR+sD10nUyhZBmx927gpnU7x8Yx8zak5XCN2Wd/rLpLxzZI8ahB7NBo60L4dJgmi/An
	hoMJlULpYStSM5YizxMbl9WOZXM3Jk2Lb1NxGSYK48JlQDwR1w7NMjg/QEFq+XDOaXHNI8Noe6Q
	B+Mta5yLTEDTpkPQyBmlxQ61lqBIKHP3YznBgxUIPhGV9Ar8Dl8DfZ2T5NEtB20vEB7cIwcERWW
	1CmukIwtjVL7BPmSlseGeD5by2QZ+gdCUMrCShUlgmw2t4tFvxN7Ai5RscxUBZ70dlmACGcWyFR
	MiU+SE9cKxd7lbq3bw8wH7PMx/+UgAmQWJF/SeJYhh9Gb0+iPR3yVjlnEZuuan004PDGrGmCOJE
	LthDMt1av/8oTZaFiK7qtUZ3Qx1GovzPjNoGLGQ6RsM+awie2XJqe12LhHdGine080jrj59L5Ox
	6UpedXIydjfwQ1Bmn7fBHfatRzc536zHComR1sy+JavhoaJE3683tYrnT1HJAoDeSIAITqYXPbw
	YQU1SJR6J2xxE3DstxtgH0VL6U1+IhoH8DPVhLuYD8=
X-Received: by 2002:a05:600c:5492:b0:495:7eab:3abd with SMTP id 5b1f17b1804b1-496b5736f4fmr90983825e9.33.1785111053770;
        Sun, 26 Jul 2026 17:10:53 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-116-215.95.114.pool.telefonica.de. [95.114.116.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4d8d6efsm201357975e9.0.2026.07.26.17.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 17:10:52 -0700 (PDT)
Date: Mon, 27 Jul 2026 02:10:19 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] ARM: traps: Implement KCFI trap handler for ARM32
Message-ID: <amafzynVg0_hlOZN@gmail.com>
References: <20260715175223.make.153-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715175223.make.153-kees@kernel.org>

On Wed, Jul 15, 2026 at 10:52:27AM +0100, Kees Cook wrote:
> +bool arm_cfi_handle_failure(struct pt_regs *regs, enum bug_trap_type type)
> +{
> +	switch (type) {
> +	case BUG_TRAP_TYPE_BUG:
> +		die("Oops - CFI", regs, 0);
> +		break;
> +	case BUG_TRAP_TYPE_WARN:
> +		/* Permissive mode: skip the trapping instruction and continue. */
> +		instruction_pointer(regs) += 4;
> +		break;

On Thumb-2, Clang emits a 16-bit BKPT for CFI checks.
This skips the following Thumb instruction.

Thanks,
Karl
