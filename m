Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219341A9F96
	for <linux-hardening@vger.kernel.org>; Wed,  2 Sep 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356422; cv=pass; b=KZX2pfZW6uCMRelwczANbDwTu1GeA60lBqxIqdm1FCULwLawD0PT/n+aoQRQVC5wDPRwwkRCgjVpFwHdvg3H1QP11Xed0Y1IxVmffHdQUEqyX8glkmz+rIy35jTvFQz1rN6IQcZVjroEuukbe5doBeEvXaTFhfNFFZ7KZIP9mzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356422; c=relaxed/simple;
	bh=t00JTA5JI17KHSj4FG9gzzx0ktA1h2Ge/6wt8hj4nsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYRJ+GR/qSXMjIde/NGrWiUJjRdT9/JXTXkhGb3xW7CW8I8AtjdE8AHdSrASs1zpVJXtYHb5qsbNzjfcuOB3fAk864SwIbxiV5Poyy7plwfTO96bgBbPfJX3WHSm8hakBAGJLexj6JvUMXU3rtTTDQSRk8C2hWPCiLw8QJO9MJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHb8yMFo; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHb8yMFo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso11237335ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 02 Sep 2026 06:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356420; cv=none;
        d=google.com; s=arc-20260327;
        b=j3yY4CGI6Wqdpms7vzxmu4cl2ugUFl2xYnwglcxE1eYP4EcBzEB1sDxTpPsuCRHK9W
         V70zLxMA0UA75c1lzee3kbcnIffMjS33o9gx9SH3CtiYMZzxQjeUrCbExjgujO2O9/YX
         aSoqtvbll/OFeNrJG8hwacn65G/WuyGCl9PdKzipGvTE8I4C+F36QjwO/2Xx8s7TK53U
         1D+BsE5s+KU+/YC0IVgBkTH4qz00oT8kXDaDwnIWlO2qrsfc3JIg30rZVi1DENECQVZk
         HTDDYCJjOJP35ssRhDH/9ff3fg3kPxCajiXM59e4LnFwtk1lIla6EPzx+1GhUDVGeb0w
         pgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t00JTA5JI17KHSj4FG9gzzx0ktA1h2Ge/6wt8hj4nsM=;
        fh=WFHI8DyqfSNW1BM0cUMu1TaaX8K3hItQd1jwU10RktU=;
        b=ZBqz8w4Nm+VxKX7NJh3dldu09+NaOLJBAeM/bATA8ZrMPHeCXrrir6y6cJ0EkTNZE4
         LGLtg9XunSXxRHh+s5edo2h9cemR70JihjaXlEvPXUzdhs4xJlCCGyWGDCSPRFXZhGw8
         y7cfOgEfKPoHqw++S+MybWITnqkQ1YAi7OwTZr13vAqSVN4W6oZyMjHUgUz2JpySV6n5
         1cS0untp5ozNhUll7dlYWgX3rpKbYQYWtP2j39pgYhASCN/ZwcFvt2mIbCkQKAEzMUVC
         nRKf9TQPA2f5OcPLB8WjlGT9yOY9hZPLZOI+DeMIAmUsLULBDWZFz0e1eNw6n5D/l1D3
         3N4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356420; x=1788961220; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t00JTA5JI17KHSj4FG9gzzx0ktA1h2Ge/6wt8hj4nsM=;
        b=NHb8yMFoBqqCwpylVvR55G8aD0dbxTFv539qhxaCQPx5IiDblhOEJyqJfK1EclGx1H
         +KYw9GDrodDkOPUI3tS/7Siw3mv1tulmmlw129cL9sFTAKsplB5rpqa/h3/WbMBNhlnd
         fHRHIQrN7TepLeufFHgr96mmQ3VEtQsQLq+Y/HsojjA6dK5oKqjlHk3UYYOcNpyFJKf9
         Xa5o0EAuAzxRM1Go8fpAworzQLP5APLJSN0HVM7iWi1sdGYC9eY4qJh/jiNhA6GwjNJS
         cHlrd1uogj0MrFg1atTF7yV12PpkcMdrI/ilI3nR/Snd9zhzannUNfZpVxAzoARhFXzb
         mPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356420; x=1788961220;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t00JTA5JI17KHSj4FG9gzzx0ktA1h2Ge/6wt8hj4nsM=;
        b=GH+lkQo+DG8FFjIimr+TLy7t2gbAA+k/Jn9zhohvtbxTgpBOD7VeFDuNhe9bXWRdgc
         355PlJm/hn71gbo3EgI39y+Q4+RjlS13/Tq/SUClz95yyVQiCPz0Ti2KNgM7nIsZ1UD0
         0kGWd0gNXmQ4bu686KUKADymMPeG0jwVZac19ooiZN3105+yyfwM3td+9Cj0EWMe0q3l
         xEP+x+sghWhp590Bwka4+m9JEbA4zRCrkRxnIotcFg6IeYZZkgaGSgHNMl+JNIWjKonu
         bk71JdEMfLFvFYd5YmRDgKPWTtmPW3ZOyaU0gykOK0CrUXjJvt2w+z/UNh1IlnoaX0+f
         14SQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiBfrzW9mlhAOXikjl88vSivryllkbaR2Y6ycuFRR3wA/ltPD8Xk/HYze48VFfMaMtlnKhMLFiFRo+JAkc2Ug=@vger.kernel.org
X-Gm-Message-State: AFuF++kQDsLGfbBOrEaPXySfVuBsSmBY6ogWTqod4Jpy8zLOrrQzOnJg
	0hCgwrMw+AmKN8GZ2rR99Tx7E/3T1bqDXCwk/LTqyPwbkDbDa4gdRnkXbPoA9fRlMk7/kM0ZvaH
	WmC00Jcwv3Uhe2tz7NeAHbTcG7m/hjempc5jv
X-Gm-Gg: AYBFou3qoi8ZFqhr5wqmjiBkMbrVh2MuVhjVkR375+H0NRlBYQeXc+MlqYxx96G09n/
	aqxCb5MAJAiJ1RvQ6T7wvvZyL1TBM6lFWsj3TMWEW5q2kUOFr4hTen5QxaLoTl9mo2a8wHrn3pk
	d8R1yHYbFXYVqAXUXUzxMtyCTV9H2tWiGt/TecyIKIjfAT/z/w/0iC6AI7xEQhFaZHO++lC0h/p
	bub6F88kEEucu7yFZQE1yRA1iYODcUysZWjqIXiiwW6P23H64LK7bgDJEGuQkXCiqZXx5aZKcJT
	A5uPWDen+S8saSX+y+kXK7Ayg9t0d+hHHwb5+Go1cSk6XPNIDzls/9tucSpIG4fcy51FrhNHhxp
	L
X-Received: by 2002:a17:903:3810:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2daec5e6457mr50995905ad.8.1788356420282; Wed, 02 Sep 2026
 06:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624073921.11037-1-harshal24.chavan@gmail.com>
 <20260624124019.4521-1-harshal24.chavan@gmail.com> <87fr2auzq3.fsf@mailhost.krisman.be>
 <CADCAkb6wuR7vT3chfFtBL0qma+gx-2mJM7v+JJLS00W3oyb5dg@mail.gmail.com> <CADCAkb63_kAa0b09GAQApBqi9-oUR03beQajkSMKL6Q4bkpWWg@mail.gmail.com>
In-Reply-To: <CADCAkb63_kAa0b09GAQApBqi9-oUR03beQajkSMKL6Q4bkpWWg@mail.gmail.com>
From: Harshal Chavan <harshal24.chavan@gmail.com>
Date: Wed, 2 Sep 2026 19:10:07 +0530
X-Gm-Features: AcwNN1VUjqEwRgnK6GyRmJMkrEFmdiPSGjgCIvG4yM_VLNIiC17js23pm59iOGU
Message-ID: <CADCAkb6s_M--WheFHQny=iGWx9WKpk9bpsjkxaHMszxUCPtR9A@mail.gmail.com>
Subject: Re: [PATCH v6] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
To: Gabriel Krisman Bertazi <krisman@suse.de>, axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, gustavoars@kernel.org, 
	io-uring@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

Just a gentle ping
As a quick refresher: Gabriel reviewed the recent changes.
We are just waiting for your high-level thoughts regarding the overall approach.

Thanks,
Harshal
