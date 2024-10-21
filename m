Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF414A90
	for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482536; cv=none; b=BhdmZloN1a76AvRXGV8ObRp8RTBSWGV4MeUlmMw1zX7CKZtkbUR6PQeRXaDi9omUpH0fc7Nq0Y3dusOmrGQHfILs2Vg2rk86kVA0oVkog5m1zC1wW78V98ltvT1Xr7C4hptF+mSwqeksG0IoW2VQGtrA7YtH1TnLldEfwRGMQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482536; c=relaxed/simple;
	bh=s39vV3y5/wyPQvNBwosAHsP68m4xIiafls5wj2/8Q64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtBQZvn6Fd3MxuYwiEAZLp1rd9iJCoQr19+7WwsIljy3mwKdjpNFPeBPuUVbzzfxa2rtUQP30AcMKXMMy6heUnqQpMXwpUjYcq6FN1AAGpcgdjdSbrhi9ovys+Nzv186vxlJoKLuquckAqN5I0nalXBi1Hn3JnKDHoEFoZmVs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuJb3OF2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuJb3OF2"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b13bf566c0so268382885a.3
        for <linux-hardening@vger.kernel.org>; Sun, 20 Oct 2024 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729482533; x=1730087333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4pjNx5rTGONCqM5YthMuQRPBDzAqva/BOxaNdI8sXU=;
        b=MuJb3OF2ltgzsgOe8pJiD89rKW4HxBZ0F9Apk8YzECy9Qxa1FRPfP7KpVeqT40CFl6
         K72MjtRSCaOtCwjOK//4vCn//JMJURCzsdYsEBHSYZOjgGeoQqndqaZc/rbWGD+hSs6A
         7rdcAC1T6TM6cAcBzh1VgqMHwhLPCLypRr7nTk8ghC9qFiNndfyZUZJnZcZ76Mg791N8
         Ywwjem9BovKHkzgRigHOCxRqQXX9ITtOhni+n7krHxfGoHqut+JI4W0XapqUK4+kmi4D
         3oyBAKyWuenjy7KI5sgVI/ri1qhgWn/ZAd/qG98OeTgUuZsmRdINrHamk/D55P52bvuM
         ZWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729482533; x=1730087333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4pjNx5rTGONCqM5YthMuQRPBDzAqva/BOxaNdI8sXU=;
        b=E+WJVo8EUk4qpmrb/wStxG6sISf0cYfQTFPnUMwWBIERSnRiqMruSPG78u4n0Mg1pe
         45aZT8nGb/+i6azJyIhTtKwaUgzWcSOJsLQNCuyesvpXKPesOWvF8xr57Ba5hzhJsg89
         Dh6jYfFNmu32GW7sfZhX6gLVRBN1UyRTIWXv5ydB9C8Rd78snRo94afXk7RnUrWT39Ca
         Lm6bJqI5nW6/S0239BNltMTVRoXJCjTIBKmMuKSuT7r4Tx7jwr80CnvKIbZKafvv7tQd
         +FUj59W7v0AMZ2Y6aP1Ghhy6Cva8xQLbI3C+r2DEueNJcGrD+g5GcBbruFTbOIk3h/Of
         p0AA==
X-Forwarded-Encrypted: i=1; AJvYcCUEPgVRc+xxSiFPLuP5htqEi8jtQaJaXWR9K1g244yj3lbh7RtKEbaCEZ7822Zpo2ljTID7Nsc3vUEKRua/mzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxetQPeVcAAZQF+ssiygZvB+i54DfVaIvFz0evhRBjrQYLJVspo
	4vNvcj87TUprfeIk4l04/l9Mkju1ov8bD/ep6ijzwI37+rk6dq75/+ZHB/ilThDsPh7sCbty1g2
	YirNEGgD/Iymx1pEHI5BvVjjEkA8=
X-Google-Smtp-Source: AGHT+IH4F9xLpRWplneHOL+E7ADlbWIT5lbbKiGiI0yGV7c+hBSrqyrjaMtw+TspcQ6e8IAD951nDqNFsCYgdAxi0HQ=
X-Received: by 2002:a05:6214:4808:b0:6cb:e57b:c37f with SMTP id
 6a1803df08f44-6cde1559b18mr166903616d6.25.1729482533301; Sun, 20 Oct 2024
 20:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410171420.1V00ICVG-lkp@intel.com> <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>
 <202410170847.F6C111256F@keescook> <202410170922.0B55ABC@keescook>
 <202410170946.C3D7594@keescook> <202410171059.C2C395030@keescook>
In-Reply-To: <202410171059.C2C395030@keescook>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 21 Oct 2024 11:48:15 +0800
Message-ID: <CALOAHbDDx3ban6xgxX0M52MNs0vUE4U2oFEy6LFAphjtU20avA@mail.gmail.com>
Subject: Re: Fwd: [linux-next:master 4380/4439] include/linux/fortify-string.h:293:17:
 error: call to '__write_overflow' declared with attribute error: detected
 write beyond size of object (1st parameter)
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:00=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Oct 17, 2024 at 09:48:18AM -0700, Kees Cook wrote:
> > On Thu, Oct 17, 2024 at 09:23:25AM -0700, Kees Cook wrote:
> > > On Thu, Oct 17, 2024 at 09:07:13AM -0700, Kees Cook wrote:
> > > > Something in the .config is causing the error. (!?) I will start a
> > > > CONFIG bisect...
> > >
> > > Well, I did a code bisect first, and it reported this which makes _no=
_
> > > sense:
> > > 8afd8c8faa24 ("lsm: remove lsm_prop scaffolding")
> > >
> > > O_o
> >
> > Looks like a GCC inlining bug. If I query the size of the destination
> > buffer before calling strscpy the warning magically vanishes. :|
> >
> > Lovely. I will see if I can construct a work-around.
>
> I am extremely bothered that this fixes it:
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index bc052b4b5a1d..891f4294361d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
>         context->target_auid =3D audit_get_loginuid(t);
>         context->target_uid =3D task_uid(t);
>         context->target_sessionid =3D audit_get_sessionid(t);
> -       security_task_getlsmprop_obj(t, &context->target_ref);
>         strscpy(context->target_comm, t->comm);
> +       security_task_getlsmprop_obj(t, &context->target_ref);
>  }
>
>  /**
> @@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t=
)
>                 ctx->target_auid =3D audit_get_loginuid(t);
>                 ctx->target_uid =3D t_uid;
>                 ctx->target_sessionid =3D audit_get_sessionid(t);
> -               security_task_getlsmprop_obj(t, &ctx->target_ref);
>                 strscpy(ctx->target_comm, t->comm);
> +               security_task_getlsmprop_obj(t, &ctx->target_ref);
>                 return 0;
>         }
>
>
> I will continue trying to figure out why GCC is getting confused here,
> but in the meantime, perhaps this is a viable workaround?

Thank you for the analysis. I was able to reproduce the issue with GCC
11 and confirmed that your change resolves it. While this does appear
to be a GCC bug, identifying the root cause may not be
straightforward. I agree that a workaround is the best approach for
now.

Feel free to include your change.

Tested-by: Yafang Shao <laoar.shao@gmail.com>


--
Regards
Yafang
