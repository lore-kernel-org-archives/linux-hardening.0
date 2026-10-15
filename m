Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B03E44F6
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043178; cv=pass; b=nCQPt97DxkByz0+5c25/ijJzCnEdB+6CdEYl8ilr+7NbxuPwHrYDvzEdW43s1SCataqVIGRurrmDB0+oJ/cpMvqabQLFASeXIjNnmgAH3u3YL4aU/u1xWyzLayt2xjiNqI0vNaIKIObBWtpHY/SihaUlDZNZdUXsm5T1sn1cdaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043178; c=relaxed/simple;
	bh=qezJc4NEIZrhsd5+TuSsc3OnyYFh7Gr+9COlR9C28hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHT5Z/44YccDGz3loheQINhocppt3LbCQTOcAEur+VTmwbVXHBwDLuoflDrxYGkF/4dm3xnff3Vry/4DaEFYjYDQLc7Pm2E7R06I6/89Ev/BiVMDqImb/cLfUpqLtu5A6Bb6okWTg89+7c+TwJv4p8W//RwvvmZb1JmqjaYzba8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqRhXJAz; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqRhXJAz"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-313bab9cfe7so591975eec.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 22:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792043176; cv=none;
        d=google.com; s=arc-20260327;
        b=iJPkwM22MHegBmFCKyWEdjYdjQrjH3+OEYyfPMkcn3FFS/dqTXT1KZrnmgTO7rMLet
         Jz6scp6KHzlGrpY8YQ+nL8JLcAJcif8iXHNhHFtuAIETJ3OMUfrqmTU1j0of6w4tCy2Q
         /sHPGeUL0XpXA0owItZ1FGyXd2p7NySmQ8gGhwvjk6kNgX/31Kdcir/YQFbQCc/bvray
         p1QA9qd5H75NR2+Z23EVLq3dO9PjgNWXSyYui8VPo9uathPqnHADD0wVY7hVZYhiIPaO
         RTZF1C7LX71+XQGD2EZS583xhmSDL1QV882Kx6K24D5dji4QcsoMi3wHwCHBIvuWJCGO
         ih1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeI0uiM52DuAwWHa/ijjOCM64Bu6o2GU+woYi97808c=;
        fh=jkF+Z4ixD8lmgIxcnVUPbQW5P+lOBtAc86o6RKMUdoo=;
        b=VjQunbIH6y9bdTSrqZb49XZpO2OTax7V2oOJ61H4XYskMsWevMJewiNgGL7glP4pZP
         sK6BYvolBkmHJ3QBl9L5NoMjPOP/EW1eFvDk/kLFHgpdNUGYeI+BZlDgoAhTUdIwlhT/
         ELPXoyz3KIHse2tSzbBJ5TmzQdr68HStH5sWaoTW44Q3i32NgzT6Z5WtMVdTLPPzO/5/
         LcHjlJx86vQOz8gX3bGR1aRqZxlkbv/ShWr+J0p4Tkp8bZDmE8rWMJyFUp9No5/Hf6xM
         aHVLWnkLKwS01Te7T5M39sv7qYTbxr1xLpuvXHtoJY5apuEwtrxBVsuSC+JgJM7WEj3I
         jWww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043176; x=1792647976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HeI0uiM52DuAwWHa/ijjOCM64Bu6o2GU+woYi97808c=;
        b=bqRhXJAza1Yrp2/eRNvbssEp5MR0j3Z/JI6FUrVfNY9dB94rODj2a6opuA8FeB1lnP
         nWsNTv0PFeu1CizxuP073ENOufz4/5n6swZ7YKDdtXRLjJUM1cUUaqmSloNMv231Ghia
         GNAYBURTZmV6CgAnEy8jyHM5PFLdB69dwRgunXDAdb1QlRbMmtemCVXyd77WY+j2SnLA
         LZhEFVSC5BC+RMjchcp4rBJXfw0NoxEbyxn9WVk0QuBV5K7BrcRTljhRao4KosOAgdFZ
         Qe2BGExLNhFW886eY327ysw+o6yt2ZiqqM6EUAANOMIMN1qWGPGryd0JtzFXw1gj9q2b
         PJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043176; x=1792647976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HeI0uiM52DuAwWHa/ijjOCM64Bu6o2GU+woYi97808c=;
        b=Xszx5jHz1xXkf+XEJrILAlZivrpC8b6vIe/oTThfNibIG/d641toJoGh3vKJj2pyCA
         fcos/f7IZl3lpu01yjUMtI7flMLTkVH1wg9ZPTcE6n5ZgRYzh76Aa/yhjDph4YifhUWJ
         mJp/FP2tYg27Z11YZIUWX6osy6+hUILngrttD7StY+81F6kUvE/miuvRKPdu1M7Uwp/I
         ZIF+wCCsGOi+QoW3GUcRfBIlhQ9XUejSEPio8DnnI/paSsYrKB40BADFIg5hCSS1a/Bi
         KJxluCu+cuF8hUsmVtqvTlyCCgGKDlac52O1JnZwq0+5tia1JuW5DLLjDrwdcGsEN63O
         NuBg==
X-Forwarded-Encrypted: i=1; AKwUvBwBWxyYtPxdL1JlW4G76K3bJsKwcNBpstoW0hhf88Elmn/1BBpckfb51KhHFmSV5CIzaiWECv4BdA0ptuq8JHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQ+7VVEJ8CVTs43l93uFjCLGzCVgy98DKYP8SSIVR2ztNrB3qZ
	EEjwGxosYxsx4STZQJKXAs/RfK7sWT3fvOCCWo2SMUzQ6vC923DXmqNq9HxqrAdWDFaQhG1wmIe
	aASW7pNGsTM7J6xW0mx5ZZbf9fAgtRq4=
X-Gm-Gg: AYBFou3bpGA8bdMZ7Mn5cGidYV8O8Xp1kDGJcJVwW6Zm5TxKARAqXMa5V7QyInOu7Ql
	gqAcWjK/D5uDB7Ll+V7kdujTYpgJvz/lEQ0JlzTBrg9VLAWo35lyEsWLc++mmIuue258kPOvtbW
	aWsJQHm4L1CD/cETkaiJUu4nIX69rrHavGoU97DZPazs+5h77s5NOI8zIHU+Bto7nYrC7DfrH+l
	hQ4gpNjdD8q30XDFpsvd7aFOxP5otouPiAArZw+c7/p1iMjpqBDV5mdESH30Bd1UUlnNJNSGZFe
	tT3YZVO4LvgcjdcYZx4Qb8ruEm9uZGkH6VarBPJ9wI8fG/D453HPYmBYLdBN6F3bSn8yyJw65yR
	6m6mkMLoxU3RZs/EyzATSUHf9V0HEbSp0mffmvk/cZ0lKS35zLDb1pgfsaRUXiPUn6UvbpDZodM
	OJs3dlEcXCzqCWhFhaczO0yfjL+Lm8wMnh0zs8tsBowHKTI2jFfxA=
X-Received: by 2002:a05:7300:da12:b0:35d:4c5b:766c with SMTP id
 5a478bee46e88-35d4c5b7a5cmr10711045eec.2.1792043176087; Wed, 14 Oct 2026
 22:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh>
In-Reply-To: <2026101517-profane-opponent-4523@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Oct 2026 07:46:02 +0200
X-Gm-Features: AclHuK9JUbZ8Kk1BEvh1a9rSCsQ_67UzDaXAR0CwzEKJckJP8Us1pVzDHAMPGB4
Message-ID: <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Greg KH <greg@kroah.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:21=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> Anyway, I don't know.  I like this feature, and maybe it's going to be
> used so infrequently it's not a big deal, but feels clunky.

Perhaps we could call it something shorter, like `__explicit_init` or
similar -- I don't see that substring (even without the double
underscores) used anywhere.

Cheers,
Miguel
