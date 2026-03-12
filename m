Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C713AD53C;
	Thu, 12 Mar 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299554; cv=none; b=rGfXrhJq3/msn+Vv9e0pKewi9fy+A5EII0XEo3VmXNSZS6nDk1Sgut8qCl1D9r3L9NkXnk5AWGZE2ycmU3KytthWTVH8NmZFhAzk8JI/xE23w+fA4cUqdXIm8TE4DZq+d8tgA69xIl8hcbQrvwGx5poHayvkyGKEnc5BnGkuZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299554; c=relaxed/simple;
	bh=Znhgh5VpMegTURFUzFsOSwJlqZmT0mMIAtISYNXYSXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mol0A1MnoIMvNSU6ttph7BYbG0c17jkV/kqA6jikNiXpFTna8J89c1DhBoLxEbU9m3wCCR/9ocJvFp9fuCp4uEJPIXoftdiZ3bfSibO6SLTa8vQdBcfklorRKaJrMX6JSweaal4liBLNAwqcfoF5LgCQQrGo5lOCXW4rRneBjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8Ra4+cy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8Ra4+cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64416C2BCB3;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=Znhgh5VpMegTURFUzFsOSwJlqZmT0mMIAtISYNXYSXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8Ra4+cyC4cAuvdogezwt+o/z6U138dgnco6Lr6PABVV2eDL3RarhuTdCZqqKAqQF
	 hmL0ErRTpCt/L8WNZJ+vvwfiXRfybStNmQJZFnnV1+n1O0gxsjb9XZL0eRnODSZKzg
	 X/GjSdZKqtJ1qJ3s8QGk5FSeDlL7G3FPjArfDicI+SHJmTuh8dtdaGEyVLvNW1FRal
	 DpoDkfvroqXjNbearS+lZi603mR+jtZeiHwJXo6qDGdJXpd4FWxhVRfK3fGWROGcQG
	 V7gmY8ufafEM20tmB0bW4IHkZarmkT1P9x4N1nhUEQikNGsL4hEfSZfHZmRraOy1OW
	 umwd3OxIpT3Nw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077gK-1lGt;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 05/20] docs: kdoc_re: add a C tokenizer
Date: Thu, 12 Mar 2026 08:12:13 +0100
Message-ID: <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Handling C code purely using regular expressions doesn't work well.

Add a C tokenizer to help doing it the right way.

The tokenizer was written using as basis the Python re documentation
tokenizer example from:
	https://docs.python.org/3/library/re.html#writing-a-tokenizer

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <c63ad36c81fe043e9e33ca55630414893f127413.1773074166.git.mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 234 +++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 085b89a4547c..7bed4e9a8810 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -141,6 +141,240 @@ class KernRe:
 
         return self.last_match.groups()
 
+class TokType():
+
+    @staticmethod
+    def __str__(val):
+        """Return the name of an enum value"""
+        return TokType._name_by_val.get(val, f"UNKNOWN({val})")
+
+class CToken():
+    """
+    Data class to define a C token.
+    """
+
+    # Tokens that can be used by the parser. Works like an C enum.
+
+    COMMENT = 0     #: A standard C or C99 comment, including delimiter.
+    STRING = 1      #: A string, including quotation marks.
+    CHAR = 2        #: A character, including apostophes.
+    NUMBER = 3      #: A number.
+    PUNC = 4        #: A puntuation mark: ``;`` / ``,`` / ``.``.
+    BEGIN = 5       #: A begin character: ``{`` / ``[`` / ``(``.
+    END = 6         #: A end character: ``}`` / ``]`` / ``)``.
+    CPP = 7         #: A preprocessor macro.
+    HASH = 8        #: The hash character - useful to handle other macros.
+    OP = 9          #: A C operator (add, subtract, ...).
+    STRUCT = 10     #: A ``struct`` keyword.
+    UNION = 11      #: An ``union`` keyword.
+    ENUM = 12       #: A ``struct`` keyword.
+    TYPEDEF = 13    #: A ``typedef`` keyword.
+    NAME = 14       #: A name. Can be an ID or a type.
+    SPACE = 15      #: Any space characters, including new lines
+
+    MISMATCH = 255  #: an error indicator: should never happen in practice.
+
+    # Dict to convert from an enum interger into a string.
+    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
+
+    # Dict to convert from string to an enum-like integer value.
+    _name_to_val = {k: v for v, k in _name_by_val.items()}
+
+    @staticmethod
+    def to_name(val):
+        """Convert from an integer value from CToken enum into a string"""
+
+        return CToken._name_by_val.get(val, f"UNKNOWN({val})")
+
+    @staticmethod
+    def from_name(name):
+        """Convert a string into a CToken enum value"""
+        if name in CToken._name_to_val:
+            return CToken._name_to_val[name]
+
+        return CToken.MISMATCH
+
+    def __init__(self, kind, value, pos,
+                 brace_level, paren_level, bracket_level):
+        self.kind = kind
+        self.value = value
+        self.pos = pos
+        self.brace_level = brace_level
+        self.paren_level = paren_level
+        self.bracket_level = bracket_level
+
+    def __repr__(self):
+        name = self.to_name(self.kind)
+        if isinstance(self.value, str):
+            value = '"' + self.value + '"'
+        else:
+            value = self.value
+
+        return f"CToken({name}, {value}, {self.pos}, " \
+               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
+
+#: Tokens to parse C code.
+TOKEN_LIST = [
+    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
+
+    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
+    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
+
+    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
+                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
+
+    (CToken.PUNC,    r"[;,\.]"),
+
+    (CToken.BEGIN,   r"[\[\(\{]"),
+
+    (CToken.END,     r"[\]\)\}]"),
+
+    (CToken.CPP,     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
+
+    (CToken.HASH,    r"#"),
+
+    (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
+                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),
+
+    (CToken.STRUCT,  r"\bstruct\b"),
+    (CToken.UNION,   r"\bunion\b"),
+    (CToken.ENUM,    r"\benum\b"),
+    (CToken.TYPEDEF, r"\bkinddef\b"),
+
+    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
+
+    (CToken.SPACE,   r"[\s]+"),
+
+    (CToken.MISMATCH,r"."),
+]
+
+#: Handle C continuation lines.
+RE_CONT = KernRe(r"\\\n")
+
+RE_COMMENT_START = KernRe(r'/\*\s*')
+
+#: tokenizer regex. Will be filled at the first CTokenizer usage.
+re_scanner = None
+
+class CTokenizer():
+    """
+    Scan C statements and definitions and produce tokens.
+
+    When converted to string, it drops comments and handle public/private
+    values, respecting depth.
+    """
+
+    # This class is inspired and follows the basic concepts of:
+    #   https://docs.python.org/3/library/re.html#writing-a-tokenizer
+
+    def _tokenize(self, source):
+        """
+        Interactor that parses ``source``, splitting it into tokens, as defined
+        at ``self.TOKEN_LIST``.
+
+        The interactor returns a CToken class object.
+        """
+
+        # Handle continuation lines. Note that kdoc_parser already has a
+        # logic to do that. Still, let's keep it for completeness, as we might
+        # end re-using this tokenizer outsize kernel-doc some day - or we may
+        # eventually remove from there as a future cleanup.
+        source = RE_CONT.sub("", source)
+
+        brace_level = 0
+        paren_level = 0
+        bracket_level = 0
+
+        for match in re_scanner.finditer(source):
+            kind = CToken.from_name(match.lastgroup)
+            pos = match.start()
+            value = match.group()
+
+            if kind == CToken.MISMATCH:
+                raise RuntimeError(f"Unexpected token '{value}' on {pos}:\n\t{source}")
+            elif kind == CToken.BEGIN:
+                if value == '(':
+                    paren_level += 1
+                elif value == '[':
+                    bracket_level += 1
+                else:  # value == '{'
+                    brace_level += 1
+
+            elif kind == CToken.END:
+                if value == ')' and paren_level > 0:
+                    paren_level -= 1
+                elif value == ']' and bracket_level > 0:
+                    bracket_level -= 1
+                elif brace_level > 0:    # value == '}'
+                    brace_level -= 1
+
+            yield CToken(kind, value, pos,
+                         brace_level, paren_level, bracket_level)
+
+    def __init__(self, source):
+        """
+        Create a regular expression to handle TOKEN_LIST.
+
+        While I generally don't like using regex group naming via:
+            (?P<name>...)
+
+        in this particular case, it makes sense, as we can pick the name
+        when matching a code via re_scanner().
+        """
+        global re_scanner
+
+        if not re_scanner:
+            re_tokens = []
+
+            for kind, pattern in TOKEN_LIST:
+                name = CToken.to_name(kind)
+                re_tokens.append(f"(?P<{name}>{pattern})")
+
+            re_scanner = KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)
+
+        self.tokens = []
+        for tok in self._tokenize(source):
+            self.tokens.append(tok)
+
+    def __str__(self):
+        out=""
+        show_stack = [True]
+
+        for tok in self.tokens:
+            if tok.kind == CToken.BEGIN:
+                show_stack.append(show_stack[-1])
+
+            elif tok.kind == CToken.END:
+                prev = show_stack[-1]
+                if len(show_stack) > 1:
+                    show_stack.pop()
+
+                if not prev and show_stack[-1]:
+                    #
+                    # Try to preserve indent
+                    #
+                    out += "\t" * (len(show_stack) - 1)
+
+                    out += str(tok.value)
+                    continue
+
+            elif tok.kind == CToken.COMMENT:
+                comment = RE_COMMENT_START.sub("", tok.value)
+
+                if comment.startswith("private:"):
+                    show_stack[-1] = False
+                    show = False
+                elif comment.startswith("public:"):
+                    show_stack[-1] = True
+
+                continue
+
+            if show_stack[-1]:
+                    out += str(tok.value)
+
+        return out
+
+
 #: Nested delimited pairs (brackets and parenthesis)
 DELIMITER_PAIRS = {
     '{': '}',
-- 
2.53.0

